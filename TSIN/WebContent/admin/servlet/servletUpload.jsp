<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="common.Path" %>
<%@ page import="upload.UploadProgressListener" %>
<%@ page import="upload.AddVideoRecord" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Servlet Upload</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String title = "";
	String type = "";
	String introduction = "";
	// System.out.println(title);
	String videoName = "";
	String coverName = "";
	
	File file;
	int maxFileSize = 5000000 * 1024;
	int maxMemSize = 50000 * 1024;
	String filePath = new String(Path.ORIGINFILEPATH);
	String coverPath = new String(Path.COVERPATH);
	
	// 验证上传内容了类型
	String contentType = request.getContentType();
	if ((contentType.indexOf("multipart/form-data") >= 0)) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置内存中存储文件的最大值
		factory.setSizeThreshold(maxMemSize);
		// 本地存储的数据大于 maxMemSize.
		factory.setRepository(new File(Path.REPOSITORY));

		// 创建一个新的文件上传处理程序
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 设置最大上传的文件大小
		upload.setSizeMax(maxFileSize);
		
		UploadProgressListener uploadProgressListener = new UploadProgressListener();
		upload.setProgressListener(uploadProgressListener);
		session.setAttribute("uploadProgressListener", uploadProgressListener);

		try { 
			// 解析获取的文件
			List fileItems = upload.parseRequest(request);
			// 处理上传的文件
			Iterator i = fileItems.iterator();

			String path;
			while (i.hasNext ()) {
				FileItem fi = (FileItem)i.next();
				if (!fi.isFormField()) {
					// 获取上传文件的参数
					String fieldName = fi.getFieldName();
					System.out.println("fieldName: " + fieldName);
					String fileName = fi.getName();
					System.out.println("fileName: " + fileName);
					if(fileName.endsWith("jpg") || fileName.endsWith(".jpeg") || fileName.endsWith(".png")) {
						path = coverPath;
						coverName = fileName;
					} else {
						path = filePath;
						videoName = fileName;
					}
					boolean isInMemory = fi.isInMemory();
					System.out.println("isInMemory: " + isInMemory);
					long sizeInBytes = fi.getSize();
					System.out.println("size: " + sizeInBytes);
					// 写入文件
					if(fileName.lastIndexOf("\\") >= 0) {
						file = new File(path, 
						fileName.substring(fileName.lastIndexOf("\\")));
					} else {
						file = new File(path,
						fileName.substring(fileName.lastIndexOf("\\") + 1));
					}
					fi.write(file);
					out.println("Uploaded Filename: " + path + 
					fileName + "<br>");
				} else {
					String fieldName = fi.getFieldName();
					String fieldValue = fi.getString();
					if(fieldName.equals("title")) {
						title = fieldValue;
					} else if(fieldName.equals("section")) {
						type = fieldValue;
					} else if(fieldName.equals("introduction")) {
						introduction = fieldValue;
					}
				}
			}
			AddVideoRecord addRecord = new AddVideoRecord();
			addRecord.addVideoRecord(title, Path.VIDEOREPO + videoName, Path.COVERREPO + coverName, type, introduction);
		} catch(Exception ex) {
			System.out.println(ex);
		} finally {
			session.removeAttribute("uploadProgressListener");
		}
	} else {
		out.println("<p>No file uploaded</p>"); 

	}
	response.setHeader("refresh","2;URL=" + request.getHeader("Referer"));
	%>
</body>
</html>
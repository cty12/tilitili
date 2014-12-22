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
<%@ page import="video.Transcoding" %>
<%@ page import="exception.*" %>

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
	String videoName = "";
	String coverName = "";
	boolean hasCover = false;
	
	File file;
	// 设置文件大小上限
	int maxFileSize = 500000 * 1024;
	int maxMemSize = 5000 * 1024;
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
		// 设置监听器
		UploadProgressListener uploadProgressListener = new UploadProgressListener();
		upload.setProgressListener(uploadProgressListener);
		session.setAttribute("uploadProgressListener", uploadProgressListener);

		try { 
			// 解析获取的文件
			List fileItems = upload.parseRequest(request);
			// 处理上传的文件
			Iterator i = fileItems.iterator();

			while (i.hasNext ()) {
				FileItem fi = (FileItem)i.next();
				// 如果这一项是文件
				if (!fi.isFormField()) {
					// 获取上传文件的参数
					String fieldName = fi.getFieldName();
					// for debug
					// System.out.println(fieldName);
					String fileName = fi.getName();

					String path;
					if(fieldName.equals("cover")) {		// 这一项是封面
						if(fileName.equals("")) {
							hasCover = false;
							path = coverPath;
							coverName = videoName.substring(0, videoName.lastIndexOf(".")) + ".jpg";
						} else {
							if(fileName.endsWith("jpg")
									|| fileName.endsWith(".jpeg") 
									|| fileName.endsWith(".png")
									|| fileName.endsWith(".gif")) {	// 以合法的后缀结尾
								hasCover = true;
								path = coverPath;
								coverName = fileName;
							} else {
								throw new InvalidExtensionException("not a img");
							}
						}
					} else if(fieldName.equals("file")) {	//这一项是文件
						if(fileName.endsWith(".avi")
								|| fileName.endsWith(".mpg")
								|| fileName.endsWith("wmv")
								|| fileName.endsWith("3gp")
								|| fileName.endsWith("mov")
								|| fileName.endsWith("mp4")
								|| fileName.endsWith(".asf")
								|| fileName.endsWith("asx")
								|| fileName.endsWith("flv")) {
							path = filePath;
							videoName = fileName;
						} else {
							throw new InvalidExtensionException("not a video");
						}
					} else {
						throw new InvalidFieldException("invalid field");
					}
					// System.out.println("isInMemory: " + fi.isInMemory());
					// System.out.println("size: " + fi.getSize());
					// 写入文件
					if(! fileName.equals("")) {
						if(fileName.lastIndexOf("\\") >= 0) {
							file = new File(path, 
							fileName.substring(fileName.lastIndexOf("\\")));
						} else {
							file = new File(path,
							fileName.substring(fileName.lastIndexOf("\\") + 1));
						}
						fi.write(file);
						out.println("****** UPLOAD SUCCESS ****** <br>");
						out.println("Uploaded Filename: " + path + fileName + "<br>");
					}
				} else {	// 是其它项目
					String fieldName = fi.getFieldName();
					String fieldValue = fi.getString("utf-8");
					if(fieldName.equals("title")) {
						title = fieldValue;
					} else if(fieldName.equals("section")) {
						type = fieldValue;
					} else if(fieldName.equals("introduction")) {
						introduction = fieldValue;
					}
				}
			}
			System.out.println("upload ends normally");
			
			// 开始转码
			Transcoding transcode = new Transcoding();
			transcode.transcode(videoName, videoName.substring(0, videoName.lastIndexOf(".")), hasCover);
			System.out.println("transcode ends normally");
			File originalVideo = new File(Path.ORIGINFILEPATH + videoName);
			if(originalVideo.isFile() && originalVideo.exists()) {
				originalVideo.delete();
				System.out.println("delete original video");
			}
			
			// 写入数据库
			AddVideoRecord addRecord = new AddVideoRecord();
			addRecord.addVideoRecord(title, Path.VIDEOREPO + videoName.substring(0, videoName.lastIndexOf(".")) + ".flv", Path.COVERREPO + coverName, type, introduction);
			addRecord.release();
			System.out.println("add database record successfully");
		} catch(Exception ex) {
			out.println("****** UPLOAD FAILED ****** <br>");
			System.out.println(ex);
		} finally {
			session.removeAttribute("uploadProgressListener");
		}
	} else {
		out.println("****** NO FILE UPLOADED ****** <br>"); 
	}
	response.setHeader("refresh","1;URL=" + request.getHeader("Referer"));
%>
</body>
</html>
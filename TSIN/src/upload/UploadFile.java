package upload;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import common.Path;

public class UploadFile extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		File file;
		int maxFileSize = 5000000 * 1024;
		int maxMemSize = 50000 * 1024;
		String filePath = new String(Path.ORIGINFILEPATH);
		String coverPath = new String(Path.COVERPATH);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();

		// 验证上传内容了类型
		String contentType = request.getContentType();
		// System.out.println("contentType: " + contentType);
		// System.out.println("indexOf: " + contentType.indexOf("multipart/form-data"));
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
			HttpSession session = request.getSession();
			session.setAttribute("uploadProgressListener", uploadProgressListener);

			try { 
				// 解析获取的文件
				List fileItems = upload.parseRequest(request);
				// 处理上传的文件
				Iterator i = fileItems.iterator();
		
				out.println("<html>");
				out.println("<head>");
				out.println("<title>JSP File upload</title>");  
				out.println("</head>");
				out.println("<body>");
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
						} else {
							path = filePath;
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
					}
				 }
				 out.println("</body>");
				 out.println("</html>");
			} catch(Exception ex) {
				System.out.println(ex);
			}
		} else {
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet upload</title>");  
			out.println("</head>");
			out.println("<body>");
			out.println("<p>No file uploaded</p>"); 
			out.println("</body>");
			out.println("</html>");
		}
	}
}
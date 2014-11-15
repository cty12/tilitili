<%@ page import="upload.AddVideoRecord" %>
<%@ page import="play.VideoInfo" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="common.Path" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Removing...</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	int videoNum = Integer.parseInt(request.getParameter("videoNum"));
	
	AddVideoRecord addVideoRecord = new AddVideoRecord();
	VideoInfo vInfo = new VideoInfo();
	
	out.println("共有视频: " + videoNum + "个 <br>");
	for(int i = 0; i < videoNum; i ++) {
		out.println(request.getParameter("chbox" + i) + "<br>");
		String videoId = request.getParameter("chbox" + i);
		if(videoId != null) {
			ResultSet rs = vInfo.getVideoInfoById(videoId);
			addVideoRecord.removeVideoRecord(videoId);
			out.println("to remove: " + rs.getString("id") + "; " + rs.getString("title") + "<br>");
			File video = new File(Path.WORKINGDIR + rs.getString("path"));
			if(video.isFile() && video.exists()) {
				System.out.println("delete video: " + video.delete());
			}
			File cover = new File(Path.WORKINGDIR + rs.getString("icon"));
			if(cover.isFile() && cover.exists()) {
				System.out.println("delete cover: " + cover.delete());
			}
		}
	}
	
	addVideoRecord.release();
	vInfo.release();
	
	response.sendRedirect("../manage.jsp");
%>
</body>
</html>
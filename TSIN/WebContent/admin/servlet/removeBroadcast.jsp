<%@ page import="java.sql.*"%>
<%@ page import="video.Broadcast" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="broadcast" class="video.Broadcast" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Removing...</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	int videoNum = Integer.parseInt(request.getParameter("videoNum"));
	
	out.println("共有视频: " + videoNum + "个 <br>");
	for(int i = 0; i < videoNum; i ++) {
		String videoId = request.getParameter("chbox" + i);
		if(videoId != null) {
			broadcast.deleteBroadcast(videoId);
		}
	}
	
	
	broadcast.release();
	response.sendRedirect("../broadcastManage.jsp");
%>
</body>
</html>
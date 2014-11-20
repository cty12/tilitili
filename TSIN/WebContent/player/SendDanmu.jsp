<%@ page import="play.Danmu"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="danmu" class="play.Danmu" scope="request" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title></title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String videoId = request.getParameter("id");
	if (videoId == null || videoId.equals("")) {
		response.setHeader("refresh", "0;../index.jsp");
		return;
	}
	System.out.println(videoId);
	String stime = request.getParameter("stime");
	String mode = request.getParameter("mode");
	String size = request.getParameter("size");
	String color = request.getParameter("color");
	String date = request.getParameter("date");
	String text = request.getParameter("text");
	String [] params = {stime, mode, size, color, date, text};
	danmu.saveDanmuInfoById(videoId, params);
%>
	<script type="text/javascript">window.close()</script>
</body>
</html>
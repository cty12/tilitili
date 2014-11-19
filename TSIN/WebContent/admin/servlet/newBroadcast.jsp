<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="login.GetUserInfo" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
    
<!DOCTYPE>
<jsp:useBean id="broadcast" class="video.Broadcast" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新建直播</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String source = request.getParameter("source");
		String introduction = request.getParameter("introduction");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date currentTime = new java.util.Date();
		String date = formatter.format(currentTime);
		broadcast.newBroadcast(title, source, date, introduction);
		broadcast.release();
		response.sendRedirect("../broadcastManage.jsp");
	%>

</body>
</html>
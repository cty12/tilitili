<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<jsp:useBean id="comment" class="video.Comment" scope="request" />
<html>
<head>
<meta charset=UTF-8">
<title>发表评论</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date currentTime = new java.util.Date();
		String date = formatter.format(currentTime);
		comment.newComment(id, date, content, session.getAttribute("studentid").toString());
		comment.release();
		response.sendRedirect("../video.jsp?id=" + id);
	%>

</body>
</html>
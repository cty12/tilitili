<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<jsp:useBean id="collect" class="video.Collect" scope="request" />
<html>
<head>
<meta charset=UTF-8">
<title>删除收藏</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String video = request.getParameter("id");
		String student = session.getAttribute("studentid").toString();
		if (collect.hasCollected(video, student)) {
			collect.deleteIt(video, student);
		}
		collect.release();
		response.sendRedirect("myCollection.jsp");
	%>

</body>
</html>
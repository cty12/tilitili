<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<jsp:useBean id="collect" class="video.Collect" scope="request" />
<html>
<head>
<meta charset=UTF-8">
<title>收藏视频</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String video = request.getParameter("id");
		String student = session.getAttribute("studentid").toString();
		if (!collect.hasCollected(video, student)) {
			collect.collectIt(video, student);
		}
		collect.release();
		//response.sendRedirect("../video.jsp?id=" + video);
	%>

</body>
</html>
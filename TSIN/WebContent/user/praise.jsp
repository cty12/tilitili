<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE>
<jsp:useBean id="like" class="video.Like" scope="request" />
<html>
<head>
<meta charset=UTF-8">
<title>赞一下</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String video = request.getParameter("id");
		String student = session.getAttribute("studentid").toString();
		if (!like.hasPraised(video, student)) {
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
			java.util.Date currentTime = new java.util.Date();
			String date = formatter.format(currentTime);
			like.likeIt(video, student, date);
		}
		like.release();
		System.out.print(video);
		//response.sendRedirect("../video.jsp?id=" + video);
	%>

</body>
</html>
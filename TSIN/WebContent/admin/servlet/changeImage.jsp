<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="slide" class="video.Slide" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更改轮播图片</title>
<link href="/TSIN/css/lavish-bootstrap.css" rel="stylesheet">
<link href="/TSIN/css/style.css" rel="stylesheet">
</head>
<body>
<%
	String path = request.getParameter("path");
	String link = request.getParameter("link");
	String replace = request.getParameter("replace");
	if (path.length()==0 || path.length()>255 || link.length()==0 || link.length()>255)
	{
		
%>
		<div class="panel panel-info login-panel">
			<div class="panel-heading">
				格式不正确
			</div>
			<div class="panel-body">
				<h5><font face="微软雅黑">2秒后跳转到登录页面</font></h5>
				<p>
				<h5><font face="微软雅黑"><a href="../website.jsp">如果没有跳转，请点这里</a></font></h5>
			</div>
		</div>
<%
		response.setHeader("refresh","2;URL=../website.jsp");
	}
	else
	{
		slide.changeSlide(path, link, replace);
		response.sendRedirect("../website.jsp");
	}
%>
</body>
</html>
<%
slide.release();
%>
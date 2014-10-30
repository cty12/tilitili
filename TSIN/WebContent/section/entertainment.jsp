<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Display" %>

<!DOCTYPE html>
<jsp:useBean id="videoDisplay" class="video.Display" scope="request" />
<html>
<head>
<meta charset="UTF-8">
<title>TiliTili视频网</title>

<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link href="../css/lavish-bootstrap.css" rel="stylesheet">

</head>
<body>
	
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="../img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-default" role="navigation" >
				<div class="col-md-6 col-md-offset-1" align="left">
					<ul class="nav navbar-nav">
						<li><a href="../index.jsp"><font face="微软雅黑"> 首页 </font></a></li>
						<li><a href="news.jsp"><font face="微软雅黑"> 新闻 </font></a></li>
						<li><a href="study.jsp"><font face="微软雅黑"> 学习 </font></a></li>
						<li><a href="life.jsp"><font face="微软雅黑"> 生活 </font></a></li>
						<li class="active"><a href=""><font face="微软雅黑"> 娱乐 </font></a></li>
						<li><a href="others.jsp"><font face="微软雅黑"> 其他 </font></a></li>
					</ul>
				</div>
				<div class="col-md-4" align="left">
					<form class="navbar-form navbar-right" role="search" action="search.jsp" method="get">
						<input type="text" class="form-control" id="content" name="content" placeholder="请输入搜索内容">
						<button type="submit" class="btn btn-primary"><font face="微软雅黑">搜索</font></button>
					</form>
				</div>
			</nav>
		</div>
	</div>
	
	<%@ include file="../topbar.jsp" %>
	<script src="../js/jquery-1.11.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
<%
	videoDisplay.release();
%>
</html>
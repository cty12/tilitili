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

<link href="css/style.css" rel="stylesheet">
<link href="css/lavish-bootstrap.css" rel="stylesheet">

</head>
<body>
	
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-default" role="navigation" >
				<div class="col-md-6 col-md-offset-1" align="left">
					<ul class="nav navbar-nav">
						<li class="active"><a href=""><font face="微软雅黑"> 首页 </font></a></li>
						<li><a href="section/news.jsp"><font face="微软雅黑"> 新闻 </font></a></li>
						<li><a href="section/study.jsp"><font face="微软雅黑"> 学习 </font></a></li>
						<li><a href="section/life.jsp"><font face="微软雅黑"> 生活 </font></a></li>
						<li><a href="section/entertainment.jsp"><font face="微软雅黑"> 娱乐 </font></a></li>
						<li><a href="section/others.jsp"><font face="微软雅黑"> 其他 </font></a></li>
					</ul>
				</div>
				<div class="col-md-4" align="left">
					<form class="navbar-form navbar-left" role="search" action="search.jsp" method="get">
					    <div class="form-group">
					        <input type="text" class="form-control" id="content" name="content" placeholder="请输入搜索内容">
					    </div>
					    <button type="submit" class="btn btn-primary"><font face="微软雅黑">搜索</font></button>
					</form>
				</div>
			</nav>
		</div>
	</div>
	<div class="row">
		<div class="col-md-2 col-md-offset-1" >
			<h3><span class="label label-primary">最热视频</span></h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-offset-1">
			<%
				videoDisplay.getLastFive();
				while(videoDisplay.getRs().next())
				{
			%>
			<div class="col-md-2" align="center">
				<a href="<%= "video.jsp?id="+videoDisplay.getRs().getString(1) %>" target="_blank">
					<img class="img-thumbnail img-sm" src="<%= videoDisplay.getRs().getString(4) %>" alt="图片无法显示">
				</a>
				<div class="row" align="center"><small><b><font face="微软雅黑"><%= videoDisplay.getRs().getString(2) %></font></b></small></div>
			</div>
			<%
				}
			%>
		</div>
	</div>

	<%@ include file="topbar.jsp" %>
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
<%
	videoDisplay.release();
%>
</html>
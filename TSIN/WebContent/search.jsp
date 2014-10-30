<%@ page import="play.VideoInfo"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<jsp:useBean id="videoInfo" class="play.VideoInfo" scope="request" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>搜索结果</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/lavish-bootstrap.css" rel="stylesheet">
</head>
<%
	request.setCharacterEncoding("utf-8");
	Enumeration<String> paraNames = request.getParameterNames();
	String exactPara = paraNames.hasMoreElements() ? paraNames.nextElement() : "";
	if (!exactPara.equals("content")) {
		response.setHeader("refresh", "0;index.jsp");
		return;
	}
	String key = request.getParameter("content");
	ResultSet vlist = videoInfo.findVideoByKey(key);
%>
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
							<li><a href="index.jsp"><font face="微软雅黑"> 首页 </font></a></li>
							<li><a href="section/news.jsp"><font face="微软雅黑"> 新闻 </font></a></li>
							<li><a href="section/study.jsp"><font face="微软雅黑"> 学习 </font></a></li>
							<li><a href="section/life.jsp"><font face="微软雅黑"> 生活 </font></a></li>
							<li><a href="section/entertainment.jsp"><font face="微软雅黑"> 娱乐 </font></a></li>
							<li><a href="section/others.jsp"><font face="微软雅黑"> 其他 </font></a></li>
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
		<div class="row">
		<div class="col-md-10 col-md-offset-1">
		<% if (!key.equals("") && vlist != null) { 
			vlist.last();
			int resultNum = vlist.getRow(); //得到当前行号，也就是记录数  
			vlist.beforeFirst();
		%>
		<h5><small>搜索 </small><%= key %>   <small>    为您找到<%= resultNum %>个结果</small></h5>
		<hr>
		<h4>相关视频</h4>
		<%
			vlist.beforeFirst();
			while (vlist.next()) {
		%>
		<div class="panel panel-default">
			<div class="panel-body">
				<li class="media">
					<a class="pull-left" href="#">
						<img class="media-object" src=<%= "\"" + vlist.getString("icon") + "\"" %> alt="..." height="120px" width="160px">
					</a>
					<div class="media-body">
					<a href="video.jsp?id=<%= vlist.getString("id") %>"><h4 class="media-heading"><%= vlist.getString("title") %></h4></a>
					<h6>上传时间：<%= vlist.getString("time") %></h6>
					<h5><small><%= vlist.getString("introduction") == null? "这家伙什么也没说" : vlist.getString("introduction") %></small></h5>
					</div>
				</li>
			</div>
		</div>
		<%	}
		   } else if (!key.equals("") && vlist == null) { %>
		<center>未搜索到相关视频</center>
		<% } %>
		</div>
		</div>
		<%@ include file="topbar.jsp" %>
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
</body>
</html>
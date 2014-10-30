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
	<title>Tilitili在线视频播放</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap-theme.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
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
	<div class="container" id="search_container">
		<div class="page-header">
			<h1>Tilitili Video Search <small>Demo</small></h1>
		</div>
		<center></center>
		<form class="form-inline" role="form" action="search.jsp" method="get">
			<div class="form-group">
				<label for="search" class="sr-only">关键词</label>
				<input type="text" class="form-control" id="search" name="content" <%= key.equals("") ? "" : ("value=\"" + key + "\"") %> placeholder="在此输入要搜索的内容">
			</div>
			<button type="submit" class="btn btn-default">搜索</button>
		</form><br>
		

		<% if (!key.equals("") && vlist != null) { %>
		<%
			vlist.beforeFirst();
			while (vlist.next()) {
		%>
		<div class="panel panel-default"><div class="panel-body">
			<li class="media">
				<a class="pull-left" href="#">
					<img class="media-object" src=<%= "\"" + vlist.getString("icon") + "\"" %> alt="..." height="120px" width="160px">
				</a>
				<div class="media-body">
				<a href="video.jsp?id=<%= vlist.getString("id") %>"><h4 class="media-heading"><%= vlist.getString("title") %></h4></a>
				<h6>上传时间：<%= vlist.getString("time") %></h6>
				<h5><%= vlist.getString("introduction") %></h5>
				</div>
			</li>
		</div></div>
		<%	}
		   } else if (!key.equals("") && vlist == null) { %>
		<center>未搜索到相关视频</center>
		<% } %>


	</div>
</body>
</html>
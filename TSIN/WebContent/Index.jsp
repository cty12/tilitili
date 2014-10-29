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

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>
	<div class="row">
		<div class="col-md-6 col-md-offset-1">
			<ul class="nav nav-pills nav-justified">
				<li class="active"><a href=""><font face="微软雅黑">首页</font></a></li>
				<li><a href="news.jsp"><font face="微软雅黑">新闻</font></a></li>
				<li><a href="study.jsp"><font face="微软雅黑">学习</font></a></li>
				<li><a href="life.jsp"><font face="微软雅黑">生活</font></a></li>
				<li><a href="entertainment.jsp"><font face="微软雅黑">娱乐</font></a></li>
				<li><a href="others.jsp"><font face="微软雅黑">其他</font></a></li>
			</ul>
		</div>
		<div class="col-md-4">
			<form class="form-inline" role="form" action="search.jsp" method="get">
				<input type="text" class="form-control" id="content" name="content" placeholder="请输入搜索内容">
				<button type="submit" class="btn btn-primary"><font face="微软雅黑">搜索</font></button>
			</form>
		</div>
	</div>

	<div class="row">
		<div class="col-md-10 col-md-offset-1">
					<%
						videoDisplay.getLastFive();
						System.out.println(videoDisplay.getRs());
	  					while(videoDisplay.getRs().next())
	  					{
	  				%>
	  					<div class="col-md-2 col-md-offset-1" align="left">
							<div class="row">
								<a href="<%= videoDisplay.getRs().getString(3) %>" target="_blank">
									<img class="img-thumbnail" src="<%= videoDisplay.getRs().getString(4) %>" alt="图片无法显示">
								</a>
							</div>
							<div class="row" align="center"><small><b><font face="微软雅黑"><%= videoDisplay.getRs().getString(2) %></font></b></small></div>
						</div>
	  				<%
	  					}
	  				%>
		</div>
	</div>

	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
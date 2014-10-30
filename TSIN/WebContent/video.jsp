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
	<link href="css/lavish-bootstrap.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jwplayer.js"></script>
</head>
<%
	request.setCharacterEncoding("utf-8");
	Enumeration<String> paraNames = request.getParameterNames();
	String exactPara = paraNames.hasMoreElements() ? paraNames.nextElement() : null;
	if (exactPara == null || !exactPara.equals("id")) {
		response.setHeader("refresh", "0;index.jsp");
		return;
	}
	String videoId = request.getParameter("id");
	ResultSet vInfo = videoInfo.getVideoInfoById(videoId);
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
				<h1><%= vInfo == null ? "该视频不存在" : vInfo.getString("title") %></h1><hr>
				<div id="player">Loading the player...</div>
			</div>
		</div>
		
		<script type="text/javascript">
		    jwplayer("player").setup({
		    	playlist: [{
		            sources: [{
		            	file: <%= vInfo == null ? "\"notexist.flv\"" : "\"" + vInfo.getString("path") + "\"" %>
		            }],
		            title: <%= vInfo == null ? "\"该视频不存在\"" : "\"" + vInfo.getString("title") + "\"" %>,
			        <% if (vInfo != null) {
						String intro = vInfo.getString("introduction"); %>
		            description: <%= "\"" + (intro == null ? "" : intro) + "\"" %>,
		            image: <%= "\"" + vInfo.getString("icon") + "\"" %>
		        	<% } %>
		        }],
		        width: "100%",
		        aspectratio: "16:9",
		        skin: "Player/skins/five.xml",
		        listbar: {
		            position: 'right',
		            size: 320
		        }
		    });
		</script>

	<%@ include file="topbar.jsp" %>
</body>
</html>
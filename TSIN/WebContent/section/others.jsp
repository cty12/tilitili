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

<link href="../css/style.css" rel="stylesheet">
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link rel="icon shortcut" href="/TSIN/img/resources/favicon.ico" />

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
						<li><a href="entertainment.jsp"><font face="微软雅黑"> 娱乐 </font></a></li>
						<li class="active"><a href=""><font face="微软雅黑"> 其他 </font></a></li>
					</ul>
				</div>
				<div class="col-md-4" align="left">
					<form class="navbar-form navbar-left" role="search" action="../search.jsp" method="get">
					    <div class="form-group">
					        <input type="text" class="form-control" id="content" name="content" placeholder="请输入搜索内容" required>
					    </div>
					    <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></button>
					</form>
				</div>
			</nav>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-10 col-md-offset-1" >
			<div class="col-md-8">	
					<br>
					<h4>			
						&nbsp&nbsp<span class="glyphicon glyphicon-thumbs-up text-primary"></span><font face="微软雅黑"> 其他推荐</font> 
					</h4>
					<%
						videoDisplay.getSectionEightHighRecom("others");
						while(videoDisplay.getRs().next())
						{
					%>
					<div class="col-xs-3" align="center">
						<div class="row"> 
							<a href="<%= "../video.jsp?id="+videoDisplay.getRs().getString("id") %>" target="_blank">
								<img class="img-rounded" src="<%= "../"+videoDisplay.getRs().getString("icon") %>" alt="图片无法显示"title="<%= videoDisplay.getRs().getString("title") %>" data-container="body" data-toggle="popover" 
								data-placement="top" data-trigger="hover" data-html="true" data-content="
								<span class= 'glyphicon glyphicon-facetime-video'></span> <%= videoDisplay.getRs().getString("click")%>
								&nbsp&nbsp&nbsp<span class= 'glyphicon glyphicon-thumbs-up'></span> <%= videoDisplay.getRs().getString("praise") %>
								&nbsp&nbsp&nbsp<span class= 'glyphicon glyphicon-comment'></span> <%= videoDisplay.getRs().getString("comment") %>
								&nbsp&nbsp&nbsp<span class= 'glyphicon glyphicon-time'></span> <%= (new java.text.SimpleDateFormat("yyyy-MM-dd").format(videoDisplay.getRs().getTimestamp("time")))%>
								<br><div class='pull-left'><img class='media-object' src='<%= videoDisplay.getRs().getString("icon")%>' alt='...' height='60px' width='80px'></div>
								<small><%= videoDisplay.getRs().getString("introduction") == null? "这家伙什么也没说" :videoDisplay.getRs().getString("introduction").substring(0, 53)%></small>
								<br>">
								<div class="img-content"><small><font face="微软雅黑"><%= videoDisplay.getRs().getString("title") %></font></small></div>
							</a>
						</div>
					</div>
					<%
						}
					%>
					<div class="row"> 
					<br>
					</div>
					<h4>			
						&nbsp&nbsp<span class="glyphicon glyphicon-repeat text-primary"></span><font face="微软雅黑"> 其他动态</font> 
					</h4>
					<%
						videoDisplay.getSectionLastFourHot("others");
						while(videoDisplay.getRs().next())
						{
					%>
					<div class="col-xs-3" align="center">
						<div class="row"> 
							<a href="<%= "../video.jsp?id="+videoDisplay.getRs().getString("id") %>" target="_blank">
								<img class="img-rounded" src="<%= "../"+videoDisplay.getRs().getString("icon") %>" alt="图片无法显示"title="<%= videoDisplay.getRs().getString("title") %>" data-container="body" data-toggle="popover" 
								data-placement="top" data-trigger="hover" data-html="true" data-content="
								<span class= 'glyphicon glyphicon-facetime-video'></span> <%= videoDisplay.getRs().getString("click")%>
								&nbsp&nbsp&nbsp<span class= 'glyphicon glyphicon-thumbs-up'></span> <%= videoDisplay.getRs().getString("praise") %>
								&nbsp&nbsp&nbsp<span class= 'glyphicon glyphicon-comment'></span> <%= videoDisplay.getRs().getString("comment") %>
								&nbsp&nbsp&nbsp<span class= 'glyphicon glyphicon-time'></span> <%= (new java.text.SimpleDateFormat("yyyy-MM-dd").format(videoDisplay.getRs().getTimestamp("time")))%>
								<br><div class='pull-left'><img class='media-object' src='<%= videoDisplay.getRs().getString("icon")%>' alt='...' height='60px' width='80px'></div>
								<small><%= videoDisplay.getRs().getString("introduction") == null? "这家伙什么也没说" :videoDisplay.getRs().getString("introduction").substring(0, 53)%></small>
								<br>">
								<div class="img-content"><small><font face="微软雅黑"><%= videoDisplay.getRs().getString("title") %></font></small></div>
							</a>
						</div>
					</div>
					<%
						}
					%>
			</div>
			<div class="col-md-4">
				<br>
				<h4>			
					<font face="微软雅黑"> 其他排行</font> 
				</h4>
				<table class="table table-hover table-striped">
				<%
					videoDisplay.getSectionTenHighClick("others");
					int cnt = 1;
					while(videoDisplay.getRs().next())
					{
				%>
					<tr class="success">
						<td width="5%">
							<%= cnt%>
						</td>
						<td width="70%">
							<a href="<%= "../video.jsp?id="+videoDisplay.getRs().getString("id") %>" target="_blank">
								<%= videoDisplay.getRs().getString("title") %>
							</a>
						</td>
						<td class="text-info" width="25%">
							<small><span class= 'glyphicon glyphicon-facetime-video'></span> <%= videoDisplay.getRs().getString("click")%></small>
						</td>
					</tr>
				<%
						cnt ++;
					}
				%>
				</table>
			</div>
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
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Broadcast"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="broadcast" class="video.Broadcast" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在线直播</title>
<link href="css/lavish-bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>

<body>
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<%
		request.setCharacterEncoding("utf-8");
		String videoId = request.getParameter("id");
	%>
	<br>
	<div class="row">
		<div class="col-md-3">
			<div class="panel panel-default">
		   		<div class="panel-body">
		   			<h3>直播列表</h3>
		   			<br>
					<ul class="nav nav-pills nav-stacked">
					<%
						broadcast.getAll();
						while (broadcast.getRs().next())
						{
							System.out.println(" ");
							System.out.print(broadcast.getRs().getString("id"));
							System.out.print(videoId);
							if (broadcast.getRs().getString("id").equals(videoId))
							{
								%><li class="active"><%
							}
							else
							{
								%><li><%
							}
					%>
						<a href="broadcast.jsp?id=<%= broadcast.getRs().getString("id")%>"><%= broadcast.getRs().getString("title")%></a></li>
				   <%
						}
				   %>
				   <br>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-9">
		<%
			broadcast.getBroadcast(videoId);
			if (videoId == null)
			{
		%>
			请选择直播视频
		<%
			}
			else
			{
				broadcast.getRs().next();
		%>
			<div class="row">
				<div class="col-md-12">
					<h4><small>
					<div class="col-md-2 text-info">
						<%=broadcast.getRs().getString("title") %>
					</div>
					</small></h4>
					<h6><small>
						<div class="col-md-3">开始时间：<%=(new java.text.SimpleDateFormat("MM-dd HH:mm").format(broadcast.getRs().getTimestamp("start"))) %></div>
					</small></h6>
				</div>
			</div>
			<br>
			<div class="row">
			<div class="col-md-12">
			<%=broadcast.getRs().getString("source") %>
			</div>
			</div>
		<%	
			}
		%>
		</div>
	</div>

	<%@ include file="topbar.jsp" %>
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<%
		broadcast.release();
	%>
</body>
</html>
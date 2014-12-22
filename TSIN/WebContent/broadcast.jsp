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
<link rel="icon shortcut" href="/TSIN/img/resources/favicon.ico" />
<script src="js/jwplayer.js"></script>
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
		   			<h3><font face="微软雅黑">直播列表</font></h3>
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
						<a href="broadcast.jsp?id=<%= broadcast.getRs().getString("id")%>"><font face="微软雅黑"><%= broadcast.getRs().getString("title")%></font></a></li>
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
			<p><font face="微软雅黑">请选择直播视频</font></p>
		<%
			}
			else
			{
				broadcast.getRs().next();
		%>
			<div class="row">
				<div class="col-md-12">
					
					<div class="col-md-2 text-info">
						<h5><font face="微软雅黑"><%=broadcast.getRs().getString("title") %></font></h5>
					</div>
					
					<div class="col-md-3">
						<h5><font face="微软雅黑">开始时间：<%=(new java.text.SimpleDateFormat("MM-dd HH:mm").format(broadcast.getRs().getTimestamp("start"))) %></font></h5>
					</div>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-12">
					<div id="broadcast"><%=broadcast.getRs().getString("source") %></div>
				</div>
			</div>

			<script type="text/javascript">
			    jwplayer("broadcast").setup({
			        playlist: [{
			          sources: [{
			              file: '<%=broadcast.getRs().getString("source") %>'
			          }],
			          title: "<%=broadcast.getRs().getString("title") %>"//,
			          //description: "This example shows a binary HD and Closed Captions Buttons.",
			          //image: 'http://content.jwplatform.com/thumbs/bkaovAYt-640.jpg'
			        }],
			        skin: "player/skins/tilitili.xml",
			        aspectratio: "16:9",
			        width: "100%"
			    });
			</script>
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
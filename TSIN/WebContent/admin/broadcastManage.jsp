<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Broadcast" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="broadcast" class="video.Broadcast" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理视频</title>
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
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
			<nav class="navbar navbar-default" role="navigation">
				<div class="col-md-6 col-md-offset-1" align="left">
					<ul class="nav navbar-nav">
						<li><a href="manage.jsp"><font face="微软雅黑"> 点播视频 </font></a></li>
						<li class="active"><a href="#"><font face="微软雅黑"> 直播视频 </font></a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
	<div class="panel panel-default">
   	<div class="panel-body">
   	<br>
   	<div align="center">
   		<h2><font face="微软雅黑">管理直播视频</font></h2>
   	</div>
   	<div class="row">
   	<div class="col-md-10 col-md-offset-1">
   	<hr>
   	<%
   		broadcast.getAll();
   		ResultSet rs = broadcast.getRs();
   		rs.last();
   		int total = rs.getRow();
   		rs.beforeFirst();
   	%>
	<form name="selectVideo" action="servlet/removeBroadcast.jsp?videoNum=<%=total %>" method="post" onsubmit="return verify();">
	<p>
		<button class="btn btn-warning" id="delete" type="submit"><font face="微软雅黑">删除所选</font></button>
	</p>
	<p><font face="微软雅黑">当前共有: <%=total %> 个视频</font></p>
	<br>
	<table class="table table-condensed table-hover">
		<thead>
			<tr class="primary">
				<th><font face="微软雅黑">ID</font></th>
				<th><font face="微软雅黑">标题</font></th>
				<th><font face="微软雅黑">视频源</font></th>
				<th><font face="微软雅黑">开始时间</font></th>
				<th><font face="微软雅黑">选中</font></th>
			</tr>
		</thead>
		<tbody>
			<%
				int cnt = 0;
				while(rs.next()) {
			%>
			<tr class="info">
				<!-- 视频ID -->
				<td><font face="微软雅黑"><%=rs.getString("id") %></font></td>
				<!-- 视频标题 -->
				<td><font face="微软雅黑"><%=rs.getString("title") %></font></td>
				<!-- 视频源 -->
				<td><font face="微软雅黑"><%=rs.getString("source") %></font></td>
				<!-- 开始时间 -->
				<td><font face="微软雅黑"><%=(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("start"))) %></font></td>
				<td><input type="checkbox" name="chbox<%=cnt %>" value="<%=rs.getString("id") %>" ></td>
			</tr>
			<%
					cnt ++;
				} 
			%>
		</tbody>
	</table>
	</form>
	<hr>
	<hr>
	<div class="row">
	   	<div class="col-md-8">
			<form action="servlet/newBroadcast.jsp" method="post">
				<!-- 标题 -->
				<div class="form-group">
					<label for="title"><font face="微软雅黑">标题</font></label>
					<input name="title" id="title" type="text" class="form-control" placeholder="限20字符" required/>
				</div>
				<!-- 视频源 -->
				<div class="form-group">
					<label for="title"><font face="微软雅黑">视频源</font></label>
					<input name="source" id="source" type="text" class="form-control" placeholder="限200字符" required/>
				</div>
				<!-- 简介 -->
				<div class="form-group">
					<label for="introduction"><font face="微软雅黑">简介 (可选)</font></label>
					<textarea name="introduction" id="introduction" class="form-control" rows="3" placeholder="限500字符" ></textarea>
				</div>
				<button class="btn btn-primary" type="submit"><font face="微软雅黑">添加直播</font></button>
			</form>
		</div>
	</div>
	<hr>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	
	<script language="javascript">
		function verify() {
			var chd = false;
			<%
				for(int i = 0; i < cnt; i ++) {
			%>
				chd = chd || document.selectVideo.chbox<%=i %>.checked;
			<%
				}
			%>
			if(chd == false) {
				alert("至少选一个哟！");
				return false;
			} else {
				return true;
			}
		}
	</script>
	
	<%@ include file="../topbar.jsp" %>
	<script src="../js/jquery-1.11.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>

</body>
	<%
		broadcast.release();
	%>
</html>
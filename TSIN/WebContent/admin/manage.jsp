<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Display" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="videoDisplay" class="video.Display" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理视频</title>
<link href="../css/bootstrap.min.css" rel="stylesheet">
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>

<body>
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="../img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<div class="panel panel-default">
   	<div class="panel-body">
   	<div align="center">
   		<h1>管理视频</h1>
   	</div>
   	<div class="row">
   	<div class="col-md-10 col-md-offset-1">
   	<hr>
	<form name="selectVideo" action="manage" method="post" onsubmit="return verify();">
	<p>
		<button class="btn btn-warning" id="delete" type="submit">删除所选</button>
	</p>
	<br>
	<table class="table table-condensed table-hover">
		<thead>
			<tr class="success">
				<th>ID</th>
				<th>标题</th>
				<th>路径</th>
				<th>封面</th>
				<th>类别</th>
				<th>创建时间</th>
				<th>修改时间</th>
				<th>介绍</th>
				<th>选中</th>
			</tr>
		</thead>
		<tbody>
			<%
				videoDisplay.getAll();
				int cnt = 0;
				while(videoDisplay.getRs().next()) {
			%>
			<tr class="info">
				<td><%=videoDisplay.getRs().getString(1) %></td>
				<td><%=videoDisplay.getRs().getString(2) %></td>
				<td><%=videoDisplay.getRs().getString(3) %></td>
				<td><%=videoDisplay.getRs().getString(4) %></td>
				<td><%=videoDisplay.getRs().getString(5) %></td>
				<td><%=videoDisplay.getRs().getString(6) %></td>
				<td><%=videoDisplay.getRs().getString(7) %></td>
				<td><%=videoDisplay.getRs().getString(8) %></td>
				<td><input type="checkbox" name="chbox<%=cnt %>" value="<%=videoDisplay.getRs().getString(1) %>" ></td>
			</tr>
			<%
					cnt ++;
				} 
			%>
		</tbody>
	</table>
	</form>
	<hr>
	<button class="btn btn-primary" id="add" onclick="window.open('upload.jsp');">新增</button>
	<hr>
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
</html>
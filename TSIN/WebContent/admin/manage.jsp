<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Display" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="videoDisplay" class="video.Display" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理视频</title>
<link href="/TSIN/css/bootstrap.min.css" rel="stylesheet">
<link href="/TSIN/css/bootstrap-theme.min.css" rel="stylesheet">
<link href="/TSIN/css/style.css" rel="stylesheet">
</head>

<style type="text/css">
	body {
		background: url(/TSIN/resources/background/illustration01.jpeg);
		background-size: cover;
		background-repeat: no-repeat;
		background-attachment: fixed;
	}
</style>

<body>
	<form name="selectVideo" action="manage" method="post" onsubmit="return verify();">
	<p>
		<button class="btn btn-danger" id="delete" type="submit">删除所选</button>
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
	<br>
	<button class="btn btn-primary" id="add" onclick="window.open('upload.jsp');">新增</button>
	
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
	<script src="/TSIN/js/jquery-1.11.1.min.js"></script>
	<script src="/TSIN/js/bootstrap.min.js"></script>
</body>
</html>
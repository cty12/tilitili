<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="login.GetUserInfo" %>
<%@page import="org.apache.commons.codec.digest.DigestUtils" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	GetUserInfo getInfo = new GetUserInfo();
	String studentid = request.getParameter("studentid");
	String nicknameById = getInfo.getNickname(studentid);
	String mailById = getInfo.getMail(studentid);
	String hashById = DigestUtils.md5Hex(mailById.trim().toLowerCase());
%>
<title><%=studentid %>的个人档案</title>

<link href="css/style.css" rel="stylesheet">
<link href="css/lavish-bootstrap.css" rel="stylesheet">
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	
	<div class="panel panel-default profile-panel">
		<div class="panel-heading">
			<%=studentid %>的个人资料
		</div>
		<div class="panel-body">
				<h5>学号: </h5>
				<input name="studentid" class="form-control" type="number" value=<%=studentid %> readonly required>
				<h5>昵称: </h5>
				<input name="nickname" class="form-control" type="text" value=<%=nicknameById %> readonly required>
				<h5>邮箱: </h5>
				<input name="mail" class="form-control" type="email" value=<%=mailById %> readonly required>
				<h5>头像: </h5>
				<p>
					<img alt="avatar" src="http://www.gravatar.com/avatar/<%=hashById %>?d=retro&s=128">
				</p>
		</div>
	</div>
	
	<%@ include file="topbar.jsp" %>
</body>
</html>
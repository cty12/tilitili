<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="login.GetUserInfo" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Updating profile</title>

<link href="../css/style.css" rel="stylesheet">
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
</head>
<body>
	<div class="panel panel-info login-panel">
		<div class="panel-heading">
			个人信息已更改
		</div>
		<div class="panel-body">
			正在转向指定页面...
		</div>
	</div>
<%
	request.setCharacterEncoding("utf-8");
	GetUserInfo getInfo = new GetUserInfo();
	String studentid = request.getParameter("studentid");
	String nickname = request.getParameter("nickname");
	String mail = request.getParameter("mail");
	getInfo.updateInfo(studentid, nickname, mail);
	getInfo.release();
	response.setHeader("refresh","1;URL=" + request.getHeader("Referer"));
%>
</body>
</html>
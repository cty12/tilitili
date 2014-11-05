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
	String nickname = getInfo.getNickname(studentid);
	String mail = getInfo.getMail(studentid);
	String hash = DigestUtils.md5Hex(mail.trim().toLowerCase());
	boolean editable = false;
	if(session.getAttribute("studentid") != null &&
			session.getAttribute("studentid").toString().equals(studentid)) {
		editable = true;
	}
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
				<input name="nickname" class="form-control" type="text" value=<%=nickname %> readonly required>
				<h5>邮箱: </h5>
				<input name="mail" class="form-control" type="email" value=<%=mail %> <%=editable ? "" : "readonly" %> required>
				<h5>头像: </h5>
				<p>
					<img alt="avatar" src="http://www.gravatar.com/avatar/<%=hash %>?d=retro&s=128">
				</p>
		</div>
	</div>
	<% getInfo.release(); %>
	<%@ include file="topbar.jsp" %>
</body>
</html>
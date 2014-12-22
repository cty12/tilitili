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
<link rel="icon shortcut" href="/TSIN/img/resources/favicon.ico" />
<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	
	<div class="panel panel-default profile-panel">
		<div class="panel-heading">
			<font face="微软雅黑"><%=studentid %>的个人资料</font>
		</div>
		<div class="panel-body">
			<form role="form" action="user/updateProfile.jsp" method="post">
				<div class="form-group">
					<label for="studentid"><font face="微软雅黑">学号: </font></label>
					<input name="studentid" id="studentid" class="form-control" type="number" value=<%=studentid %> readonly required>
				</div>
				<div class="form-group">
					<label for="nickname"><font face="微软雅黑">昵称: </font></label>
					<input name="nickname" id="nickname" class="form-control" type="text" value=<%=nickname %> <%=editable ? "" : "readonly" %> required>
				</div>
				<div class="form-group">
					<label for="mail"><font face="微软雅黑">邮箱: </font></label>
					<input name="mail" id="mail" class="form-control" type="email" value=<%=mail %> <%=editable ? "" : "readonly" %> required>
				</div>
				<label for="avatar"><font face="微软雅黑">头像: </font></label>
				<p align="center" id="avatar">
					<img alt="avatar" src="http://gravatar.com/avatar/<%=hash %>?d=retro&s=150">
				</p>
				<br>
				<%if(editable) { %>
					<div class="row">
						<div class="col-md-6 col-md-offset-3">
							<button class="btn btn-info btn-block btn-sm" type="submit"><font face="微软雅黑">修改</font></button>
						</div>
					</div>
				<%} %>
			</form>
		</div>
	</div>
	<% getInfo.release(); %>
	<%@ include file="topbar.jsp" %>
</body>
</html>
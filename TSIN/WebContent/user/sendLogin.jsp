<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="login.Login" %>
<%@ page import="login.GetUserInfo" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logging in</title>

<link href="../css/style.css" rel="stylesheet">
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
</head>
<body>
	<%
		try {
			request.setCharacterEncoding("utf-8");
			String studentid = request.getParameter("studentid");
			String pwd = request.getParameter("password");
			if(Login.login(studentid, pwd)) {
				GetUserInfo getInfo = new GetUserInfo();
				getInfo.addUser(studentid);
				// studentid
				session.setAttribute("studentid", studentid);
				// nickname
				session.setAttribute("nickname", getInfo.getNickname(studentid));
				// mail
				session.setAttribute("mail", getInfo.getMail(studentid));
				// is admin or not
				session.setAttribute("admin", getInfo.isAdmin(studentid));
				getInfo.release();
				%>
					<div class="panel panel-primary login-panel">
						<div class="panel-heading">
							登录成功
						</div>
						<div class="panel-body">
							正在转向指定页面...
						</div>
					</div>
				<%
			} else {
				%>
					<div class="panel panel-info login-panel">
						<div class="panel-heading">
							登录失败
						</div>
						<div class="panel-body">
							正在转向指定页面...
						</div>
					</div>
				<%
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// response.sendRedirect(request.getHeader("Referer"));
			response.setHeader("refresh","1;URL=" + request.getHeader("Referer"));
		}
	%>
</body>
</html>
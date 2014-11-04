<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="login.Login" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logging in</title>
</head>
<body>
	<%
		try {
			request.setCharacterEncoding("utf-8");
			String studentid = request.getParameter("studentid");
			String pwd = request.getParameter("password");
			
			if(Login.login(studentid, pwd)) {
				session.setAttribute("studentid", studentid);
				// session.setAttribute("pwd", "pwd");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			response.sendRedirect("../index.jsp");
		}
	%>
</body>
</html>
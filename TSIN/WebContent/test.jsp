<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="login.SessionCounter" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test page</title>
</head>
<body>
<%
	String s = "testvideo/[MAD]刀剑神域——No pain,No game.flv";
	out.println(s.replaceAll(" ", "\\\\ "));
	String str = "NULL";
	String hash = DigestUtils.md5Hex(str.trim().toLowerCase());
	// System.out.println("URL: http://www.gravatar.com/avatar/" + hash);
%>
	<p>mail: <%=session.getAttribute("mail") %></p>
	<p>nickname: <%=session.getAttribute("nickname") %></p>
	<p>studentid: <%=session.getAttribute("studentid") %></p>
	<img src="http://www.gravatar.com/avatar/<%=hash %>?d=retro"/>
	<p><%=SessionCounter.getSessionNum() %></p>
</body>
</html>
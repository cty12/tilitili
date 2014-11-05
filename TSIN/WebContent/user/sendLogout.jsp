<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logging out</title>

<link href="../css/style.css" rel="stylesheet">
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
</head>
<body>
	<%
		session.removeAttribute("studentid");
		session.removeAttribute("mail");
		session.removeAttribute("nickname");
		%>
			<div class="panel panel-warning login-panel">
				<div class="panel-heading">
					成功登出
				</div>
				<div class="panel-body">
					正在转向指定页面...
				</div>
			</div>
		<%
		// response.sendRedirect(request.getHeader("Referer"));
		response.setHeader("refresh","1;URL=" + request.getHeader("Referer"));
	%>
</body>
</html>
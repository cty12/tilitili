<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>

	<!-- Navbar -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div id="navbar" class="collapse navbar-collapse">
				<!-- menubar content -->
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/index.jsp">回到首页</a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/broadcast.jsp">在线直播</a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/admin/manage.jsp">管理视频</a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/admin/website.jsp">网站维护</a></li>
				</ul>
					<%if(session.getAttribute("studentid") == null) { %>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">登录<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li data-toggle="modal" data-target="#loginBox"><a href="#">登录</a></li>
						</ul>
					</li>
				</ul>
					<%} else { %>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/user/myCollection.jsp">我的收藏</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<%
							String myMail = session.getAttribute("mail").toString();
							String myHash = DigestUtils.md5Hex(myMail.trim().toLowerCase());
							String myNickname = session.getAttribute("nickname").toString();
							String myStudentid = session.getAttribute("studentid").toString();
						%>
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<img src="http://gravatar.com/avatar/<%=myHash %>?d=retro&s=24"/>
							<%=myNickname %>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="/TSIN/profile.jsp?studentid=<%=myStudentid %>">个人信息</a>
							<li class="divider"></li>
							<li><a href="/TSIN/user/sendLogout.jsp">注销</a></li>
						</ul>
					</li>
				</ul>
					<%} %>
			</div>
		</div>
	</nav>
	
	<!-- Modal Login -->
	<div class="modal fade" id="loginBox" tabindex="-1" role="dialog" aria-labelledby="loginLabel" aria-hidden="true">
		<div class="modal-dialog">
    		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="loginLabel">登录</h4>
				</div>

				<div class="modal-body">
						<form class="form-signin" role="form" action="/TSIN/user/sendLogin.jsp" method="post">
							<input name="studentid" type="number" class="form-control" placeholder="学号" required autofocus>
							<input name="password" type="password" class="form-control" placeholder="密码" required>
							<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
						</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
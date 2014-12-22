<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>

	<!-- Navbar -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div id="navbar" class="collapse navbar-collapse">
				<!-- menubar content -->
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/index.jsp"><font face="微软雅黑">回到首页</font></a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/broadcast.jsp"><font face="微软雅黑">在线直播</font></a></li>
				</ul>
					<%if(session.getAttribute("admin") != null && (Boolean)session.getAttribute("admin") == true) { %>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/admin/manage.jsp"><font face="微软雅黑">管理视频</font></a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/admin/website.jsp"><font face="微软雅黑">网站维护</font></a></li>
				</ul>
					<% } %>
					<%if(session.getAttribute("studentid") == null) { %>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"><font face="微软雅黑">登录</font><span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li data-toggle="modal" data-target="#loginBox"><a href="#"><font face="微软雅黑">登录</font></a></li>
						</ul>
					</li>
				</ul>
					<%} else { %>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/user/myCollection.jsp"><font face="微软雅黑">我的收藏</font></a></li>
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
							<font face="微软雅黑"><%=myNickname %></font>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="/TSIN/profile.jsp?studentid=<%=myStudentid %>"><font face="微软雅黑">个人信息</font></a>
							<li class="divider"></li>
							<li><a href="/TSIN/user/sendLogout.jsp"><font face="微软雅黑">注销</font></a></li>
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
					<h4 class="modal-title" id="loginLabel"><font face="微软雅黑">登录</font></h4>
				</div>

				<div class="modal-body">
						<form class="form-signin" role="form" action="/TSIN/user/sendLogin.jsp" method="post">
							<input name="studentid" type="number" class="form-control" placeholder="学号" required autofocus>
							<input name="password" type="password" class="form-control" placeholder="密码" required>
							<button class="btn btn-lg btn-primary btn-block" type="submit"><font face="微软雅黑">登录</font></button>
						</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
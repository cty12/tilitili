<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

	<!-- Navbar -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div id="navbar" class="collapse navbar-collapse">
				<!-- menubar content -->
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/index.jsp">回到首页</a></li>
				</ul>
				<ul class="nav navbar-nav">
					<li><a href="/TSIN/admin/manage.jsp">管理视频</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<%if(session.getAttribute("email") == null) { %>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">登录/注册<span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li data-toggle="modal" data-target="#loginBox"><a href="#">登录</a></li>
							<li class="divider"></li>
							<li><a href="/InfoPlatform/register.jsp">注册</a></li>
						</ul>
					</li>
					<%} else { %>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"><%=session.getAttribute("username").toString() %><span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="/InfoPlatform/userinfo.jsp">个人信息</a>
							<li class="divider"></li>
							<li><a href="/InfoPlatform/logout.jsp">注销</a></li>
						</ul>
					</li>
					<%} %>
				</ul>
			</div>
		</div>
	</nav>
	
	<!-- Modal -->
	<div class="modal fade" id="loginBox" tabindex="-1" role="dialog" aria-labelledby="loginLabel" aria-hidden="true">
		<div class="modal-dialog">
    		<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="loginLabel">登录</h4>
				</div>

				<div class="modal-body">
						<form class="form-signin" role="form" action="/InfoPlatform/login.jsp" method="post">
							<input name="email" type="email" class="form-control" placeholder="Email address" required autofocus>
							<input name="password" type="password" class="form-control" placeholder="Password" required>
							<button class="btn btn-lg btn-primary btn-block" type="submit">登录！</button>
						</form>
				</div>
				<!--
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Login</button>
				</div>
				-->
			</div>
		</div>
	</div>

</body>
</html>
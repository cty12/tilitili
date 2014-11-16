<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Display" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="videoDisplay" class="video.Display" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理视频</title>
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>

<body>
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="../img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<div class="panel panel-default">
   	<div class="panel-body">
   	<div align="center">
   		<h1>网站维护</h1>
   	</div>
   	<br>
   	<div class="row">
   		<div class="col-md-10 col-md-offset-1">
			<div class="panel panel-info">
				<div class="panel-heading">
	      				<h3 class="panel-title"><font face="微软雅黑">首页轮播图片</font></h3>
	  			</div>
	  			<div class="panel-body">
					<div class="row">
						<div class="col-md-10 col-md-offset-1">
							<br>
							<form role="form" action="servlet/changeImage.jsp" method="post">
							   <div class="form-group">
							      <label for="path"><font face="微软雅黑">修改图片:</font></label>
							      <input type="text" class="form-control" id="path" name="path" placeholder="请输入新图路径（255字符）">
							   </div>
							   <div class="form-group">
							      <label for="link"><font face="微软雅黑">修改链接:</font></label>
							      <input type="text" class="form-control" id="link" name="link" placeholder="请输入跳转页面（255字符）">
							   </div>
							   <div class="form-group">
							      <label for="replace"><font face="微软雅黑">替换图片:</font></label>
							      <select class="form-control select-picker" id="replace" name="replace">
							      	<option value="1">图片1</option>
							      	<option value="2">图片2</option>
							      	<option value="3">图片3</option>
							      </select>
							   </div>
							   <button type="submit" class="btn btn-primary"><font face="微软雅黑">修改</font></button>
							</form><br>	
							<div id="message"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	
	<%@ include file="../topbar.jsp" %>
	<script src="../js/jquery-1.11.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>
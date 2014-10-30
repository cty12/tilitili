<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传视频</title>
<link href="/TSIN/css/bootstrap.min.css" rel="stylesheet">
<link href="/TSIN/css/bootstrap-theme.min.css" rel="stylesheet">
<link href="/TSIN/css/style.css" rel="stylesheet">
</head>

<style type="text/css">
	body {
		background: url(/TSIN/resources/background/illustration01.jpeg);
		background-size: cover;
		background-repeat: no-repeat;
		background-attachment: fixed;
	}
</style>

<body>
	<h1 align="center">文件上传</h1>
	<br>
	<br>
	<div class="panel panel-default file-upload">
		<div class="panel-heading">上传文件</div>
		<div class="panel-body">
			<h5>选择文件来上传</h5>
			<br>
			<form action="../upload" method="post" enctype="multipart/form-data">
				<div class="row">
					<div class="col-md-2">
						<p>视频: </p>
					</div>
					<div class="col-md-5">
						<input type="file" id="uploadFile" name="file" size="50" required />
					</div>
				</div>
				
				<br>

				<div class="row">
					<div class="col-md-2">
						<p>封面: </p>
					</div>
					<div class="col-md-5">	
						<input type="file" id="uploadCover" name="cover" size="50" requied />
					</div>
				</div>
				
				<br>
				
				<div class="row">
					<div class="col-md-6 col-md-offset-3">
						<button class="btn btn-success btn-block btn-sm" id="upload" type="submit">上传</button>
					</div>
				</div>
			</form>
			<br>
			<div class="progress">
				<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
					60%
				</div>
			</div>
		</div>
	</div>
	<script src="/TSIN/js/jquery-1.11.1.min.js"></script>
	<script src="/TSIN/js/bootstrap.min.js"></script>
</body>
</html>
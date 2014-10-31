<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传视频</title>
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<script src="../js/jquery-1.11.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>

<body>
	<div class="panel panel-default file-upload">
		<div class="panel-heading">上传文件</div>
		<div class="panel-body">
			<h5>选择文件来上传</h5>
			<br>
			<form action="servlet/servletUpload.jsp" method="post" enctype="multipart/form-data">
				<div class="row">
					<div class="col-md-2">
						<p>标题: </p>
					</div>
					<div class="col-md-10">
						<input name="title" type="text" class="form-control" placeholder="标题" required autofocus/>
					</div>
				</div>
				
				<br>
				
				<div class="row">
					<div class="col-md-2">
						<p>类别: </p>
					</div>
					<div class="col-md-10">
						<select name="section" class="form-control">
							<option value="others">其它</option>
							<option value="news">新闻</option>
							<option value="study">学习</option>
							<option value="life">生活</option>
							<option value="entertainment">娱乐</option>
						</select>
					</div>
				</div>
				
				<br>
				
				<div class="row">
					<div class="col-md-2">
						<p>简介: </p>
					</div>
					<div class="col-md-10">
						<textarea name="introduction" class="form-control" rows="2" required></textarea>
					</div>
				</div>
				
				<br>
				
				<div class="row">
					<div class="col-md-2">
						<p>视频: </p>
					</div>
					<div class="col-md-5 col-md-offset-1">
						<input type="file" id="uploadFile" name="file" size="50" required />
					</div>
				</div>
				
				<br>

				<div class="row">
					<div class="col-md-2">
						<p>封面: </p>
					</div>
					<div class="col-md-5 col-md-offset-1">	
						<input type="file" id="uploadCover" name="cover" size="50" required />
					</div>
				</div>
				
				<br>
				
				<div class="row">
					<div class="col-md-6 col-md-offset-3">
						<button class="btn btn-primary btn-block btn-sm" id="upload" type="submit">上传</button>
					</div>
				</div>
			</form>
			<br>
			<p>上传进度: </p>
			<textarea class="form-control" rows="1" id="source" readonly></textarea>
			<div class="progress" id="progress" style="visibility:hidden;">
				<div class="progress-bar" id="progressBar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
					60%
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		(function getSource() {
			$("#source").load("../progress");
			setTimeout(getSource, 500);
		}).call()
		
	</script>
	
</body>
</html>

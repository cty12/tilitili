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

<style type=text/css>
	body {
		background: url(../resources/background/illustration01_0.jpeg);
		background-size: auto;
		background-repeat: no-repeat;
		background-attachment: fixed;
	}
</style>

<body>
	<div class="panel panel-default file-upload">
		<div class="panel-heading">上传文件</div>
		<div class="panel-body">
			<form action="servlet/servletUpload.jsp" method="post" enctype="multipart/form-data" onsubmit="getSource();">
				<!-- 标题 -->
				<div class="form-group">
					<label for="title">标题</label>
					<input name="title" id="title" type="text" class="form-control" placeholder="至少填点东西" required autofocus/>
				</div>
				<!-- 分类 -->
				<div class="form-group">
					<label for="section">分类</label>
					<select name="section" id="section" class="form-control">
						<option value="others">其它</option>
						<option value="news">新闻</option>
						<option value="study">学习</option>
						<option value="life">生活</option>
						<option value="entertainment">娱乐</option>
					</select>
				</div>
				<!-- 简介 -->
				<div class="form-group">
					<label for="introduction">简介 (可选)</label>
					<textarea name="introduction" id="introduction" class="form-control" rows="3"></textarea>
				</div>
				<!-- 视频 -->
				<div class="form-group">
					<label for="uploadFile">上传视频</label>
					<input type="file" id="uploadFile" name="file" onchange="check(this)" required />
				</div>
				<!-- 封面 -->
				<div class="form-group">
					<label for="uploadCover">上传封面 (可选)</label>	
					<input type="file" id="uploadCover" onchange="check(this)" name="cover"/>
				</div>
				
				<div class="row">
					<div class="col-md-6 col-md-offset-3">
						<button class="btn btn-primary btn-block btn-sm" id="upload" type="submit">上传</button>
					</div>
				</div>
			</form>
			<br>
			
			<div class="form-group">
				<textarea class="form-control" rows="1" id="source" readonly>上传时进度将显示在这里</textarea>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function check(input) {
			var file = input.files[0];
			if((file != undefined) && (file.size > 500000 * 1024)) {
				alert('文件太大咯！');
				document.getElementById("upload").disabled = true;
			} else {
				document.getElementById("upload").disabled = false;
			}
		}
	
		function getSource() {
			document.getElementById("upload").disabled = true;
			$("#source").load("../progress");
			setTimeout(getSource, 500);
		}
		
	</script>
	
</body>
</html>

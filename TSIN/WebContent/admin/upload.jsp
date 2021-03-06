<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传视频</title>
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link rel="icon shortcut" href="/TSIN/img/resources/favicon.ico" />
<script src="../js/jquery-1.11.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</head>

<style type=text/css>
	body {
		background: url(../img/resources/illustration01_0.jpeg);
		background-size: auto;
		background-repeat: no-repeat;
		background-attachment: fixed;
	}
</style>

<body>
	<div class="panel panel-default file-upload">
		<div class="panel-heading"><font face="微软雅黑">上传文件</font></div>
		<div class="panel-body">
			<form action="servlet/servletUpload.jsp" method="post" enctype="multipart/form-data" onsubmit="getSource();">
				<!-- 标题 -->
				<div class="form-group">
					<label for="title"><font face="微软雅黑">标题</font></label>
					<input name="title" id="title" type="text" class="form-control" placeholder="至少填点东西" required autofocus/>
				</div>
				<!-- 分类 -->
				<div class="form-group">
					<label for="section"><font face="微软雅黑">分类</font></label>
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
					<label for="introduction"><font face="微软雅黑">简介 (可选)</font></label>
					<textarea name="introduction" id="introduction" class="form-control" rows="3"></textarea>
				</div>
				<!-- 视频 -->
				<div class="form-group">
					<label for="uploadFile"><font face="微软雅黑">上传视频</font></label>
					<input type="file" id="uploadFile" name="file" onchange="check(this)" required />
				</div>
				<!-- 封面 -->
				<div class="form-group">
					<label for="uploadCover"><font face="微软雅黑">上传封面 (可选)</font></label>	
					<input type="file" id="uploadCover" onchange="check(this)" name="cover"/>
				</div>
				
				<div class="row">
					<div class="col-md-6 col-md-offset-3">
						<button class="btn btn-primary btn-block btn-sm" id="upload" type="submit"><font face="微软雅黑">上传</font></button>
					</div>
				</div>
			</form>
			<br>
			
			<div align="center" style="display:none" id="progress">
				<textarea class="form-control" rows="1" id="source" readonly>上传时进度将显示在这里</textarea>
				<img src="../img/resources/spinner.gif" id="spinner" alt="spinner">
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function check(input) {
			var file = input.files[0];
			if((file != undefined) && (file.size > 500000 * 1024)) {
				alert('文件太大咯！');
				input.value = "";
			}
		}
	
		function getSource() {
			document.getElementById("upload").style.display = 'none';
			document.getElementById("progress").style.display = 'block';
			
			$("#source").load("../progress");
			setTimeout(getSource, 500);
		}
		
	</script>
	
</body>
</html>

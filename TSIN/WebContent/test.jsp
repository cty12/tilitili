<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test Page</title>
</head>
<style type="text/css"> 
/* 页面字体样式 */ 
body, td, input, textarea { 
font-family:Arial; 
font-size:12px; 
} 
</style>
<script src="js/jquery-1.11.1.min.js"></script>
<body>
	<script type="text/javascript">
		(function getSource() {
			$("#source").load("progress");
			setTimeout(getSource, 1000);
		}).call()
		
	</script>
	<textarea rows="10" cols="80" id="source"></textarea> 
</body>
</html>
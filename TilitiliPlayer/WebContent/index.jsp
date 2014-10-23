<%@ page import="jdbc.JdbcDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Tilitili在线视频播放</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap-theme.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jwplayer.js"></script>
</head>
<body>
	<div class="container">
		<div class="page-header">
			<h1>Tilitili Video Online <small>Demo</small></h1>
		</div>
		<!-- <center></center> -->
		<div id="player">Loading the player...</div>
		
		<script type="text/javascript">
		    jwplayer("player").setup({
		        file: "uploads/replace_this_file_with_an_FLV_file.flv",
		        width: "100%",
		        aspectratio: "16:9",
		        //image: "uploads/myPoster.jpg",
		        //skin: "skins/five.xml",
		    	logo: {
		    		hide: true
		    	}
		    });
		</script>

	</div>
</body>
</html>
<%@ page import="jdbc.JdbcDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" value="IE=9">
<title>Tilitili在线视频播放</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap-theme.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
		<link rel="stylesheet" href="css/base.css?1" />
		<script src="js/ABPMobile.js"></script>
		<script src="js/CommentCoreLibrary.min.js"></script>
		<script src="js/ABPLibxml.js"></script>
		<script src="js/ABPlayer.js"></script>
		<script type="text/javascript">
			window.addEventListener("load",function(){
				var inst = ABP.bind(document.getElementById("player"), isMobile());
				CommentLoader("comment-otsukimi.xml", inst.cmManager);
				inst.txtText.focus();
				inst.txtText.addEventListener("keydown", function(e){
					if(e && e.keyCode === 13){
						if(/^!/.test(this.value)) return; //Leave the internal commands
						inst.txtText.value = "";
					}
				});
				window.abpinst = inst;
				window.acpinst = ABP.create(document.getElementById("toBeInjected"), {"src":document.getElementById("new-video")});
			});
		</script>
</head>
<body>
	<div class="container">
		<div id="player" class="ABP-Unit" style="width:640px;height:480px;" tabindex="1">
			<div class="ABP-Video">
				<div class="ABP-Container"></div>
				<video id="abp-video" autobuffer="true" data-setup="{}">
					<source src="http://static.cdn.moe/ccltestingvideos/otsukimi_recital.mp4" type="video/mp4">
					<source src="http://static.cdn.moe/ccltestingvideos/otsukimi_recital.webm" type="video/webm">
					<!-- // END VIDEO 1-->
					<!-- START VIDEO 2
					<source src="http://media.w3.org/2010/05/sintel/trailer.mp4" type="video/mp4">
					// END VIDEO 2-->
					<p>Your browser does not support html5 video!</p>
				</video>
			</div>
			<div class="ABP-Text">
				<input type="text">
			</div>
			<div class="ABP-Control">
				<div class="button ABP-Play"></div>
				<div class="progress-bar">
					<div class="bar dark"></div>
					<div class="bar"></div>
				</div>
				<div class="button ABP-CommentShow"></div>
				<div class="button ABP-FullScreen"></div>
			</div>
		</div>
		<video id="new-video" autobuffer="true" data-setup="{}">
			<source src="http://content.bitsontherun.com/videos/bkaovAYt-52qL9xLP.mp4" type="video/mp4">
			<source src="http://content.bitsontherun.com/videos/bkaovAYt-27m5HpIu.webm" type="video/webm">
			<p>Your browser does not support html5 video!</p>
		</video>
		<div id="toBeInjected"></div>

	</div>
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
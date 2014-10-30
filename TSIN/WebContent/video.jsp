<%@ page import="play.VideoInfo"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<jsp:useBean id="videoInfo" class="play.VideoInfo" scope="request" />
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
<%
	request.setCharacterEncoding("utf-8");
	Enumeration<String> paraNames = request.getParameterNames();
	String exactPara = paraNames.hasMoreElements() ? paraNames.nextElement() : null;
	if (exactPara == null || !exactPara.equals("id")) {
		response.setHeader("refresh", "0;index.jsp");
		return;
	}
	String videoId = request.getParameter("id");
	ResultSet vInfo = videoInfo.getVideoInfoById(videoId);
%>
<body>
	<div class="container">
		<div class="page-header">
			<h1>Tilitili Video Online <small>Demo</small></h1>
		</div>
		<!-- <center></center> -->
		<div id="player">Loading the player...</div>
		
		<script type="text/javascript">
		    jwplayer("player").setup({
		    	playlist: [{
		            sources: [{
		            	file: <%= vInfo == null ? "\"notexist.flv\"" : "\"" + vInfo.getString("path") + "\"" %>
		            }],
		            title: <%= vInfo == null ? "\"该视频不存在\"" : "\"" + vInfo.getString("title") + "\"" %>,
			        <% if (vInfo != null) {
						String intro = vInfo.getString("introduction"); %>
		            description: <%= "\"" + (intro == null ? "" : intro) + "\"" %>,
		            image: <%= "\"" + vInfo.getString("icon") + "\"" %>
		        	<% } %>
		        }],
		        width: "100%",
		        aspectratio: "16:9",
		        skin: "Video/skins/five.xml"/*,
		        listbar: {
		            position: 'right',
		            size: 320
		        }*/
		    });
		</script>
	</div>
</body>
</html>
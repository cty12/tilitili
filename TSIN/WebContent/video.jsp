<%@ page import="play.VideoInfo"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="login.GetUserInfo" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<jsp:useBean id="videoInfo" class="play.VideoInfo" scope="request" />
<jsp:useBean id="comment" class="video.Comment" scope="request" />
<jsp:useBean id="like" class="video.Like" scope="request" />
<jsp:useBean id="collect" class="video.Collect" scope="request" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/lavish-bootstrap.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jwplayer.js"></script>
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
	<title><%= vInfo.getString("title") %></title>
</head>
<body>
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-default" role="navigation" >
				<div class="col-md-6 col-md-offset-1" align="left">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp"><font face="微软雅黑"> 首页 </font></a></li>
						<li><a href="section/news.jsp"><font face="微软雅黑"> 新闻 </font></a></li>
						<li><a href="section/study.jsp"><font face="微软雅黑"> 学习 </font></a></li>
						<li><a href="section/life.jsp"><font face="微软雅黑"> 生活 </font></a></li>
						<li><a href="section/entertainment.jsp"><font face="微软雅黑"> 娱乐 </font></a></li>
						<li><a href="section/others.jsp"><font face="微软雅黑"> 其他 </font></a></li>
					</ul>
				</div>
				<div class="col-md-4" align="left">
					<form class="navbar-form navbar-left" role="search" action="search.jsp" method="get">
					    <div class="form-group">
					        <input type="text" class="form-control" id="content" name="content" placeholder="请输入搜索内容"  required>
					    </div>
				    <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></button>
				</form>
				</div>
			</nav>
		</div>
	</div>
	<!-- <center></center> -->
	<div class="row">
		<div class="col-md-10 col-md-offset-1">
			<h2><%= vInfo == null ? "该视频不存在" : vInfo.getString("title") %></h2>
			<div class="row">
				<div class="col-md-7">
					<h4><small>
						<strong>
						<div class="col-md-2 text-info">
							<%
							if (vInfo.getString("type").equals("others"))
								out.print("其他类");
							else if (vInfo.getString("type").equals("news"))
								out.print("新闻类");
							else if (vInfo.getString("type").equals("study"))
								out.print("学习类");
							else if (vInfo.getString("type").equals("entertainment"))
								out.print("娱乐类");
							else if (vInfo.getString("type").equals("life"))
								out.print("生活类");
							%>
						</div>
						</strong>
					</small></h4>
					<h6><small>
						<div class="col-md-2"><span class="glyphicon glyphicon-facetime-video"></span> <%= vInfo.getString("click") %></div> 
						<div class="col-md-2"><span class="glyphicon glyphicon-thumbs-up"></span> <%= vInfo.getString("praise") %></div>
						<div class="col-md-2"><span class="glyphicon glyphicon-comment"></span> <%= vInfo.getString("comment") %></div>
						<div class="col-md-4"><span class="glyphicon glyphicon-time"></span> <%= (new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(vInfo.getTimestamp("time")))%></div>
					</small></h6>
				</div>
				<div class="col-md-2" id="collectBtn">
					<%
						if (session.getAttribute("studentid") != null) {
							if (!collect.hasCollected(videoId, session.getAttribute("studentid").toString())) {
					%>
					<h6><a onclick="collectVideo()">
						<small><div class="text-info"><font face="微软雅黑"><span class="glyphicon glyphicon-star"></span> 收藏本视频</font></div></small>
					</a></h6>
					<%
							} else {
					%>
					<h6>
						<small><font face="微软雅黑"><span class="glyphicon glyphicon-star"></span> 您已收藏</font></small>
					</h6>
					<%
							}
						}
					%>
				</div>
			</div>
			<hr>
			<div id="player">Loading the player...</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-7 col-md-offset-1">
			<br>
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="col-md-9" align="left">
						<h5>视频简介</h5>
					</div>
					<div class="col-md-3" align="right" id="likeBtn"">
						<%
							if (session.getAttribute("studentid") != null) {
								if (like.hasPraised(videoId, session.getAttribute("studentid").toString())) {
						%>
								<button type="button" disabled="disabled" class="btn btn-info btn-sm"><font face="微软雅黑">赞过了</font></button>
						<%
								} else {
						%>
								<button class="btn btn-info btn-sm" onclick="likeVideo()"><font face="微软雅黑">赞一下</font></button>
						<%
								}
							}
						%>
					</div>
					<div class="col-md-10" align="left">
							<h6><small>
								<%= vInfo.getString("introduction") == null? "这家伙什么也没说" : vInfo.getString("introduction") %>
							</small></h6>
					</div>
				</div>
			</div>
			<hr>
			<%
				if (session.getAttribute("studentid") != null) {
			%>
			<form role="form" method="post" action="user/newComment.jsp?id=<%= videoId%>">
				<div class="form-group">
						<label for="content">发表评论</label>
			   		<textarea class="form-control" rows="4" name="content" placeholder="评论限制在200字以内"></textarea>
				</div>
				<div class="form-group">
				    <div class="col-md-2 col-md-offset-10" >
			       		<button type="submit" class="btn btn-primary btn-block"><font face="微软雅黑">发表</font></button>
			    	</div>
				</div>
			</form>
			<hr><hr>
			<%
				} else {
			%>
				<h4><small>评论请先登录</small></h4>
			<%
				}
			%>
			
			<table class="table table-condensed table-striped table-hover" frame=void>
				<%
					GetUserInfo getInfo = new GetUserInfo();
					comment.getCommentById(videoId);
					while(comment.getRs().next())
					{
				%>
				<tr>
					<td width="15%">
						<br>
						<div class="row" align="center">
							<%
								String mail = getInfo.getMail(comment.getRs().getString("authorid"));
								String hash = DigestUtils.md5Hex(mail.trim().toLowerCase());
							%>
							<img src="http://www.gravatar.com/avatar/<%=hash %>?d=retro&s=80" id="user_img" alt="icon" />
						</div>
						<div class="row" align="center" >
							<h5><small>
							
							<a href="profile.jsp?studentid=<%=comment.getRs().getString("authorid") %>" target="_blank">
							<div class="text-info">
							<font face="微软雅黑" >
							<%=
								comment.getNameByStuNum(comment.getRs().getString("authorid"))
							%>
							</font>
							</div>
							</a>
							
							</small></h5>
						</div>
					</td>
					<td width="60%">
						<small><br></small>
						<font face="微软雅黑" ><%out.print(comment.getRs().getString("content"));%></font>
					</td>
					<td width="25%">
									<h5><small>
									<%out.print(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(comment.getRs().getTimestamp("time")));%>
									<%out.print("  " + comment.getRs().getString("seq")+"楼");%>
									</small></h5>				
					</td>
				</tr>
				<%	
					}
				%>
			</table>
		</div>
	</div>
	
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
	        skin: "Player/skins/five.xml",
	        listbar: {
	            position: 'right',
	            size: 320
	        }
	    });
	    
	    function collectVideo(vId) {
		    var xmlhttp;
		    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		    	xmlhttp=new XMLHttpRequest();
		    } else {// code for IE6, IE5
		    	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		    }
		    document.getElementById("collectBtn").innerHTML="<h6><small><font face=\"微软雅黑\"><span class=\"glyphicon glyphicon-star\"></span> 您已收藏</font></small></h6>";
		    args = String(document.location).split('?');
		    if (args[1]) args = args[1];
		    url = "user/collect.jsp?" + args;
		    xmlhttp.open("GET",url,true);
		    xmlhttp.send();
	    }
	    
	    function likeVideo(vId) {
		    var xmlhttp;
		    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		    	xmlhttp=new XMLHttpRequest();
		    } else {// code for IE6, IE5
		    	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		    }
		    document.getElementById("likeBtn").innerHTML="<button type=\"button\" disabled=\"disabled\" class=\"btn btn-info btn-sm\"><font face=\"微软雅黑\">赞过了</font></button>";
		    args = String(document.location).split('?');
		    if (args[1]) args = args[1];
		    url = "user/praise.jsp?" + args;
		    xmlhttp.open("post",url,true);
		    xmlhttp.send();
		}
	</script>
	
	<%@ include file="topbar.jsp" %>
</body>
<%
	comment.release();
	like.release();
	collect.release();
	getInfo.release();
%>
</html>
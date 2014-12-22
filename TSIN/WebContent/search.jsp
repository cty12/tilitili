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
	<title>搜索结果</title>
	<link href="css/style.css" rel="stylesheet">
	<link href="css/lavish-bootstrap.css" rel="stylesheet">
	<link rel="icon shortcut" href="/TSIN/img/resources/favicon.ico" />
</head>
<%
	request.setCharacterEncoding("utf-8");
	String key = request.getParameter("content");
	if (key == null) {
		response.setHeader("refresh", "0;index.jsp");
		return;
	}
	String type = request.getParameter("type");
	String order = request.getParameter("order");
	ResultSet vlist = videoInfo.findVideoByKey(key, type, order);
%>
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
						        <input type="text" class="form-control" id="content" name="content" placeholder="请输入搜索内容" value="<%= key %>">
						    </div>
						    <button type="submit" class="btn btn-primary"><font face="微软雅黑"><span class="glyphicon glyphicon-search"></span></font></button>
						</form>
					</div>
				</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-md-10 col-md-offset-1">
				<% if (!key.equals("") && vlist != null) { 
					vlist.last();
					int resultNum = vlist.getRow(); //得到当前行号，也就是记录数  
					vlist.beforeFirst();
				%>
				<h5><font face="微软雅黑"><small>搜索 </small><%= key %>   <small>    为您找到<%= resultNum %>个结果</small></font></h5>
				<hr>
				<p><font face="微软雅黑">视频类型：</font>
					<a href="search.jsp?content=<%=key%><%=order==null?"":"&order="+order%>">
						<button type="button" class="btn btn-<%=type==null?"info":"default"%> btn-xs"><font face="微软雅黑">全部</font></button>
					</a>
					<a href="?content=<%=key%>&type=news<%=order==null?"":"&order="+order%>">
						<button type="button" class="btn btn-<%=type!=null&&type.equals("news")?"info":"default"%> btn-xs"><font face="微软雅黑">新闻</font></button>
					</a>
					<a href="?content=<%=key%>&type=study<%=order==null?"":"&order="+order%>">
						<button type="button" class="btn btn-<%=type!=null&&type.equals("study")?"info":"default"%> btn-xs"><font face="微软雅黑">学习</font></button>
					</a>
					<a href="?content=<%=key%>&type=life<%=order==null?"":"&order="+order%>">
						<button type="button" class="btn btn-<%=type!=null&&type.equals("life")?"info":"default"%> btn-xs"><font face="微软雅黑">生活</font></button>
					</a>
					<a href="?content=<%=key%>&type=entertainment<%=order==null?"":"&order="+order%>">
						<button type="button" class="btn btn-<%=type!=null&&type.equals("entertainment")?"info":"default"%> btn-xs"><font face="微软雅黑">娱乐</font></button>
					</a>
				</p>
				<p><font face="微软雅黑">排序方式：</font>
					<a href="?content=<%=key%><%=type==null?"":"&type="+type%>">
						<button type="button" class="btn btn-<%=order==null||order.equals("time")?"info":"default"%> btn-xs"><font face="微软雅黑">发布时间</font></button>
					</a>
					<a href="?content=<%=key%><%=type==null?"":"&type="+type%>&order=click">
						<button type="button" class="btn btn-<%=order!=null&&order.equals("click")?"info":"default"%> btn-xs"><font face="微软雅黑">点击数</font></button>
					</a>
					<a href="?content=<%=key%><%=type==null?"":"&type="+type%>&order=praise">
						<button type="button" class="btn btn-<%=order!=null&&order.equals("praise")?"info":"default"%> btn-xs"><font face="微软雅黑">点赞数</font></button>
					</a>
					<a href="?content=<%=key%><%=type==null?"":"&type="+type%>&order=comment">
						<button type="button" class="btn btn-<%=order!=null&&order.equals("comment")?"info":"default"%> btn-xs"><font face="微软雅黑">评论数</font></button>
					</a>
				</p><br>
				<h4><font face="微软雅黑">相关视频</font></h4>
				<%
					vlist.beforeFirst();
					while (vlist.next()) {
				%>
				<div class="panel panel-default">
					<div class="panel-body">
						<a class="pull-left" href="video.jsp?id=<%= vlist.getString("id") %>" target="_blank">
							<img class="media-object" src=<%= "\"" + vlist.getString("icon") + "\"" %> alt="..." height="120px" width="160px">
						</a>
						<div class="media-body">
							<div class="row">
								<div class="col-md-10">
									<div class="col-md-12">
										<h5>
										<div class="row">
										<div class="col-md-1">
										<span class="label label-info">
										<font face="微软雅黑">
										<%
											if (vlist.getString("type").equals("others"))
												out.print("其他");
											else if (vlist.getString("type").equals("news"))
												out.print("新闻");
											else if (vlist.getString("type").equals("study"))
												out.print("学习");
											else if (vlist.getString("type").equals("entertainment"))
												out.print("娱乐");
											else if (vlist.getString("type").equals("life"))
												out.print("生活");
										%>
										</font>
										</span>
										</div>
										<div class="col-md-8">
										<a href="video.jsp?id=<%= vlist.getString("id") %>" target="_blank"><div class="text-info"><font face="微软雅黑" ><%= vlist.getString("title") %></font></div></a>
										</div>
										</div>
										</h5>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<h6><small>
										<div class="col-md-2"><span class="glyphicon glyphicon-facetime-video"></span> <%= vlist.getString("click") %></div> 
										<div class="col-md-2"><span class="glyphicon glyphicon-thumbs-up"></span> <%= vlist.getString("praise") %></div>
										<div class="col-md-2"><span class="glyphicon glyphicon-comment"></span> <%= vlist.getString("comment") %></div>
										<div class="col-md-4"><span class="glyphicon glyphicon-time"></span> <%= (new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(vlist.getTimestamp("time")))%></div>
									</small></h6>
								</div>
							</div>
							<div class="row">
								<div class="col-md-10">
									<div class="col-md-12">
										<h6><small><font face="微软雅黑"><%= vlist.getString("introduction") == null? "这家伙什么也没说" : vlist.getString("introduction") %></font></small></h6>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%	}
				   } else if (!key.equals("") && vlist == null) { %>
				<center>
					<h4>
						<font face="微软雅黑"><small>未搜索到与</small>&nbsp<%=key%>&nbsp<small>相关的视频</small></font>
					</h4>
				</center>
				<% } %>
			</div>
		</div>
<%
	if (vlist != null) {
		vlist.close();
	}
	videoInfo.release();
%>
		<%@ include file="topbar.jsp" %>
		<script src="js/jquery-1.11.1.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
</body>
</html>
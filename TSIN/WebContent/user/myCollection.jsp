<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="video.Collect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="collect" class="video.Collect" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的收藏</title>
<link href="../css/lavish-bootstrap.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
<link rel="icon shortcut" href="/TSIN/img/resources/favicon.ico" />
</head>

<body>
	<div class="row" align="left">
		<div class="col-md-12" >
			<img src="../img/logo.jpg" alt="tilitili" height="100%" width="100%" />
		</div>
	</div>
	<div class="panel panel-default">
	   	<div class="panel-body">
		   	<div align="center">
		   		<h1><font face="微软雅黑">我的收藏</font></h1>
		   	</div>
		   	<div class="row">
			   	<div class="col-md-10 col-md-offset-1">
			   	<hr>
					<%
						collect.getCollectionById(session.getAttribute("studentid").toString());
						while (collect.getRs().next()) {
							ResultSet vlist = collect.getVideoInfoById(collect.getRs().getString("video"));
					%>
						<div class="panel panel-default">
							<div class="panel-body">
								<a class="pull-left" href="../video.jsp?id=<%= vlist.getString("id") %>" target="_blank">
									<img class="media-object" src="<%= "../" + vlist.getString("icon")%>" alt="..." height="120px" width="160px">
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
														<a href="../video.jsp?id=<%= vlist.getString("id") %>" target="_blank"><div class="text-info"><font face="微软雅黑" ><%= vlist.getString("title") %></font></div></a>
													</div>
												</div>
												</h5>
											</div>
										</div>
										<div class="col-md-2 " align="right">
											<a href="deleteCollection.jsp?id=<%= vlist.getString("id") %>"><div class="text-info"><font face="微软雅黑" ><span class="glyphicon glyphicon-remove"></span> 删除此收藏</font></div></a>
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
					<%
							try {
								vlist.close();
							} catch (SQLException e) {
								e.printStackTrace();
							}
						} 
					%>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../topbar.jsp" %>
	<script src="../js/jquery-1.11.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<%
		collect.release();
	%>
</body>
</html>
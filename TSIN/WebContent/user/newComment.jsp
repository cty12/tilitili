<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="login.GetUserInfo" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
    
<!DOCTYPE>
<jsp:useBean id="comment" class="video.Comment" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发表评论</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String content = request.getParameter("content");
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date currentTime = new java.util.Date();
		String date = formatter.format(currentTime);
		comment.newComment(id, date, content, session.getAttribute("studentid").toString());
		//response.sendRedirect("../video.jsp?id=" + id);
	%>
	<%
		GetUserInfo getInfo = new GetUserInfo();
		comment.getCommentById(id);
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
				<img src="http://gravatar.com/avatar/<%=hash %>?d=retro&s=80" id="user_img" alt="icon" />
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
		getInfo.release();
		comment.release();
	%>

</body>
</html>
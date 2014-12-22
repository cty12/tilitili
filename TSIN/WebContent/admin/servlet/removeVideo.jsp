<%@ page import="upload.AddVideoRecord" %>
<%@ page import="play.VideoInfo" %>
<%@ page import="video.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="common.Path" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Removing...</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	int videoNum = Integer.parseInt(request.getParameter("videoNum"));
	
	AddVideoRecord addVideoRecord = new AddVideoRecord();
	VideoInfo vInfo = new VideoInfo();
	Comment comment = new Comment();
	Collect collect = new Collect();
	Like like = new Like();
	
	for(int i = 0; i < videoNum; i ++) {
		out.println(request.getParameter("chbox" + i) + "<br>");
		String videoId = request.getParameter("chbox" + i);
		if(videoId != null) {
			/**** purging video by video id ****/
			
			ResultSet rs = vInfo.getVideoInfoById(videoId);
			// 删除视频在数据库中的记录
			addVideoRecord.removeVideoRecord(videoId);
			// 删除视频评论
			comment.purgeCommentById(videoId);
			// 删除相关视频收藏
			collect.purgeCollectById(videoId);
			// 删除相关视频点赞
			like.purgeLikeById(videoId);
			
			// for debug
			// out.println("to remove: " + rs.getString("id") + "; " + rs.getString("title") + "<br>");
			// 删除文件系统中的视频
			File video = new File(Path.WORKINGDIR + rs.getString("path"));
			if(video.isFile() && video.exists()) {
				System.out.println("delete video: " + video.delete());
			} else {
				System.out.println("video remove failed: file not exist");
			}
			// 删除文件系统中的封面
			File cover = new File(Path.WORKINGDIR + rs.getString("icon"));
			if(cover.isFile() && cover.exists()) {
				System.out.println("delete cover: " + cover.delete());
			} else {
				System.out.println("cover remove fail: file not exist");
			}
			// 删除文件系统中的弹幕
			File danmu = new File(Path.WORKINGDIR + Path.DANMUREPO + "danmu" + rs.getString("id") + ".xml");
			if(danmu.isFile() && danmu.exists()) {
				System.out.println("delete danmu: " + danmu.delete());
			} else {
				System.out.println("danmu remove fail: file not exist");
			}
		}
	}
	
	addVideoRecord.release();
	vInfo.release();
	comment.release();
	collect.release();
	like.release();
	
	response.sendRedirect("../manage.jsp");
%>
</body>
</html>
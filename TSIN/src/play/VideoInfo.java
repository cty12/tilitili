package play;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class VideoInfo {
	private static String URL = "jdbc:mysql://localhost:3306/";
	private static String DATABASENAME = "tilitili";
	private Connection conn = null;

	/**
	 * 构造函数，建立与数据库的连接
	 */
	public VideoInfo() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(
				URL + DATABASENAME, "root", ""
			);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 断开与数据库的连接
	 */
	public void release() {
		try {
			if(conn != null) {
				conn.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取视频的相关信息
	 * @param videoId 视频ID
	 * @return 包含相应视频信息的ResultSet
	 */
	public ResultSet getVideoInfoById(String videoId) {
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from video where id=" + videoId);
			if (rs.next())
				return rs;
			else
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 通过关键词搜索全部类型视频，默认按创建时间排序
	 * @param keys 关键字
	 * @return 标题含有该关键字的ResultSet
	 */
	public ResultSet findVideoByKey(String keys) {
		try {
			String reg = String.join("|", keys.split("[ \t]+"));
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from video where title regexp '" + reg + "' order by time desc");
			if (rs.next())
				return rs;
			else
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 通过关键词搜索指定类型视频，按指定方式排序
	 * @param keys 关键字
	 * @param type 类型
	 * @param order 排序方式
	 * @return
	 */
	public ResultSet findVideoByKey(String keys, String type, String order) {
		try {
			String reg = String.join("|", keys.split("[ \t]+"));
			order = order == null ? "time" : order; //System.out.println("type="+type.toString()+"\norder="+order);
			Statement stmt = conn.createStatement();
			ResultSet rs;
			if (type != null) {
				rs = stmt.executeQuery(
					"select * from video where title regexp '" + reg + "' and type='" + type + "' order by " + order + " desc"
				);
			} else {
				rs = stmt.executeQuery(
					"select * from video where title regexp '" + reg + "' order by " + order + " desc"
				);
			}
			if (rs.next())
				return rs;
			else
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

}

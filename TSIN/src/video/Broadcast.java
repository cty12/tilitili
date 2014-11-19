package video;

import java.sql.*;

public class Broadcast {
	
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	
	/**类初始化，连接数据库*/
	public Broadcast() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
		} catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}

	/**
	 * 用于得到所有的直播视频列表
	 */
	public void getAll() {
		String sql = "select * from broadcast";
		execute(sql);
	}
	
	/**
	 * 获得某一个直播视频的基本信息
	 */
	public void getBroadcast(String id) {
		String sql = "select * from broadcast where id=" + id;
		execute(sql);
	}
	
	/**删除直播视频*/
	public void deleteBroadcast(String video) {
		try
		{
			PreparedStatement pstmt = conn.prepareStatement("delete from broadcast where id = ?"); 
			pstmt.setString(1, video);  
			pstmt.executeUpdate(); 
			pstmt.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**添加直播视频*/
	public void newBroadcast(String title, String source, String date, String introduction) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("insert into broadcast (title, source, start, introduction) values (?,?,?,?)"); 
			pstmt.setString(1, title);
			pstmt.setString(2, source);
			pstmt.setString(3, date);
			pstmt.setString(4, introduction);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**获取查找到的结果集合*/
	public ResultSet getRs() {
		return rs;
	}
	
	/**将命令写入SQL*/
	private void execute(String sql) {
		try {
			stm = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stm.executeQuery(sql);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**释放资源*/
	public void release() {
		try {
			if (null != rs) {
				rs.close();
			}
			if (null != stm) {
				stm.close();
			}
			if (null != conn) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

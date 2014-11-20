package video;

import java.sql.*;

public class Display {
	
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	
	/**类初始化，连接数据库*/
	public Display() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
		} catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**增加点击*/
	public void newClick(String id)
	{
		try
		{
			String sql = "select * from video where id=" + id;
			execute(sql);
			rs.next();
			int click = rs.getInt("click");
			click ++;
			PreparedStatement pstmt = conn.prepareStatement("update video set click=? where id=?");
			pstmt.setInt(1, click);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**获取最热的六个视频，用以放在首页展示*/
	public void getLastSixHot() {
		String sql = "select * from video order by recent desc limit 6";
		execute(sql);
	}
	
	/**获取分页最热的六个视频，用以放在首页展示*/
	public void getSectionLastSixHot(String section) {
		String sql = "select * from video where type=\"" + section + "\" order by recent desc limit 6";
		execute(sql);
	}
	
	/**获取最受欢迎的六个视频，用以放在首页顶栏展示*/
	public void getSixHighRecom() {
		String sql = "select * from video where time >= DATE_SUB(CURDATE(),INTERVAL 1 WEEK) order by praise desc limit 6";
		execute(sql);
	}
	
	/**
	 * 用于得到所有的视频列表
	 */
	public void getAll() {
		String sql = "select * from video";
		execute(sql);
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

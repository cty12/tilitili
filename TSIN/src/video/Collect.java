package video;

import java.sql.*;

public class Collect {
	
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	private Statement stm2;
	
	/**类初始化，连接数据库*/
	public Collect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
		} catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**确认此视频已被收藏*/
	public boolean hasCollected(String video, String student) {
		String sql = "select * from collect where video=" + video + " and student=" + student;
		execute(sql);
		try {
			if (rs.next()) {
				return true;
			}
		} catch(SQLException e) {
			System.out.println(e);
		}
		return false;
	}
	
	/**收藏此视频*/
	public void collectIt(String video, String student) {
		try {
			PreparedStatement pstmt = conn.prepareStatement("insert into collect (video, student) values (?,?)"); 
			pstmt.setString(1, video);
			pstmt.setString(2, student);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**删除收藏视频*/
	public void deleteIt(String video, String student)
	{
		try
		{
			PreparedStatement pstmt = conn.prepareStatement("delete from collect where video = ? and student = ?"); 
			pstmt.setString(1, video);  
			pstmt.setString(2, student);  
			pstmt.executeUpdate(); 
			pstmt.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**通过用户id确认获得其收藏的所有视频*/
	public void getCollectionById(String id) {
		String sql = "select * from collect where student=" + id;
		execute(sql);
	}
	
	/**通过视频id获得视频信息*/
	public ResultSet getVideoInfoById(String videoId) {
		try {
			Statement stm2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			ResultSet cs = stm2.executeQuery("select * from video where id=" + videoId);
			if (cs.next())
				return cs;
			else
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * @author cty
	 * @param videoId
	 * 删除 video 相关的收藏
	 */
	public void purgeCollectById(String videoId) {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("delete from collect where video=" + videoId);
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**得到结果集合*/
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
			if (null != stm2) {
				stm2.close();
			}
			if (null != conn) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

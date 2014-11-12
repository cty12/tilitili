package video;

import java.sql.*;

public class Collect {
	
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	
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
	
	public boolean hasCollected(String video, String student)
	{
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
	
	public void collectIt(String video, String student)
	{
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
			if (null != conn) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

package video;

import java.sql.*;

public class Like {
	
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	
	/**类初始化，连接数据库*/
	public Like() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
		} catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	public boolean hasPraised(String video, String student)
	{
		String sql = "select * from praise where video=" + video + " and student=" + student;
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
	
	public void likeIt(String video, String student, String date)
	{
		try {
			PreparedStatement pstmt1 = conn.prepareStatement("insert into praise (video, student) values (?,?)"); 
			pstmt1.setString(1, video);
			pstmt1.setString(2, student);
			pstmt1.executeUpdate();
			pstmt1.close();
			
			String sql = "select * from video where id=" + video;
			execute(sql);
			rs.next();
			int praise = rs.getInt("praise");
			praise ++;
			
			PreparedStatement pstmt2 = conn.prepareStatement("update video set recent = ?, praise = ? where id=?");
			pstmt2.setString(1, date);
			pstmt2.setInt(2, praise);
			pstmt2.setString(3, video);
			pstmt2.executeUpdate();
			pstmt2.close();
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

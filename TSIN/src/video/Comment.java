package video;

import java.sql.*;

public class Comment {
	
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	
	/**类初始化，连接数据库*/
	public Comment() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
		} catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**发表新评论*/
	public void newComment(String id, String date, String comment, String authorID)
	{
		try
		{
			String sql = "select * from video where id=" + id;
			execute(sql);
			rs.next();
			int seq = rs.getInt("nextcomment");
			PreparedStatement pstmt1 = conn.prepareStatement("insert into comment (id, seq, content, time, authorid) values (?,?,?,?,?)"); 
			pstmt1.setString(1, id);
			pstmt1.setInt(2, seq);
			pstmt1.setString(3, comment);
			pstmt1.setString(4, date);
			pstmt1.setString(5, authorID);
			pstmt1.executeUpdate();
			pstmt1.close();
			seq ++;
			int num = rs.getInt(11);
			num ++;
			PreparedStatement pstmt2 = conn.prepareStatement("update video set recent = ?, comment = ?, nextcomment = ? where id=?");
			pstmt2.setString(1, date);
			pstmt2.setInt(2, num);
			pstmt2.setInt(3, seq);
			pstmt2.setString(4, id);
			pstmt2.executeUpdate();
			pstmt2.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	public String getNameByStuNum(String num)
	{
		String sql = "select * from user where num=" + num;
		ResultSet ns = null;
		try {
			stm = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			ns = stm.executeQuery(sql);
			if (ns.next())
			{
				return ns.getString("nickname");
			}
		} catch(SQLException e) {
			System.out.println(e);
		} finally {
			try {
				ns.close();
			} catch(SQLException e) {
				System.out.println(e);
			}
		}
		return "";
	}
	
	public void getCommentById(String id)
	{
		String sql = "select * from comment where id=" + id + " order by seq desc";
		execute(sql);
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

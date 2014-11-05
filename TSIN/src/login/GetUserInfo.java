package login;

import java.sql.*;

public class GetUserInfo {
	private static String URL = "jdbc:mysql://localhost:3306/";
	private static String DATABASENAME = "tilitili";
	private Connection conn = null;
	
	public GetUserInfo() {
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
	
	public void release() {
		try {
			if(conn != null) {
				conn.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public String getMail(String studentid) {
		String mail = null;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select mail from user where num=" + studentid);
			if(rs.next()) {
				mail = rs.getString("mail");
			}
		} catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
		if(mail != null)
			return mail;
		else
			return "default@tilitili.com";
	}
	
	public String getNickname(String studentid) {
		String nickname = null;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select nickname from user where num=" + studentid);
			if(rs.next()) {
				nickname = rs.getString("nickname");
			}
		} catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
		return nickname;
	}
	
	public void addUser(String studentid) {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("insert ignore into user values (\"" + studentid + "\", \"" + studentid + "\", null)");
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateInfo(String studentid, String nickname, String mail) {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("update user set nickname=\"" + nickname + "\" where num=" + studentid);
			stmt.execute("update user set mail=\"" + mail + "\" where num=" + studentid);
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}

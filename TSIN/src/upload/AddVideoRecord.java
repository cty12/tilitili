package upload;

import java.sql.*;

public class AddVideoRecord {
	private static String URL = "jdbc:mysql://localhost:3306/";
	private static String DATABASENAME = "tilitili";
	private Connection conn = null;
	
	public AddVideoRecord() {
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
	
	public void addVideoRecord(String title, String path, String icon, 
			String type, String introduction) {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("insert into video values (0, \"" + title + "\", \"" + path + "\", \"" + icon + "\", \"" + type + 
					"\", now(), now(), \"" + introduction + "\", 0, 0, 0, 1)");	
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void removeVideoRecord(String id) {
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("delete from video where id=" + id);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}

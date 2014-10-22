package jdbc;

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
import java.util.HashMap;
import java.util.List;

public class JdbcDao {
	// public String TAG = this.getClass().getName();
	public static String URL = "jdbc:mysql://localhost:3306/";
	public static String DATABASENAME = "tilitili";
	private static JdbcDao jdbc = null;
	Connection conn = null;
	
	protected JdbcDao() {
		conn = getConn();
	}
	
	protected void finalize() {
		try {
			if(conn != null) {
				conn.close();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static JdbcDao getInstance() {
		if(jdbc == null) {
			jdbc = new JdbcDao();
		}
		return jdbc;
	}
	
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Connection getConn() {
		// System.out.println("getConn start");
		try {
			return DriverManager.getConnection(URL + DATABASENAME, "root",
					"");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	//Usage example
	public void setWeekScheduleForCourse(String courseId, String time) {
		try {
			List<String> section = new ArrayList<String>();
			for (int i = 2; i < time.length(); i += 4)
				section.add(time.substring(i - 2, i + 1));
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from week_schedule where course_id=" + courseId);
			while (rs.next()) {
				String classTime = rs.getString("time");
				if (section.contains(classTime))
					section.remove(classTime);
				else {
					Statement cstmt = conn.createStatement();
					cstmt.execute("delete from week_schedule where course_id=" + courseId + " and time=" + classTime);
					cstmt.close();
				}
			}
			for (String classTime: section)
				stmt.execute("insert into week_schedule values (null," + courseId + ", \"" + classTime + "\")");
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}

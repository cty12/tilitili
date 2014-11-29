package login;

import java.sql.*;

import login.GetUserInfo;
import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class GetUserInfoTest {

	GetUserInfo getInfo = null;
	private Connection conn = null;
	
	@Before
	public void setUp() throws Exception {
		getInfo = new GetUserInfo();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
			
			Statement stmt = conn.createStatement();
			stmt.execute("insert into user values (3014014014, 'yoo', 'yoo@bili.com')");
			stmt.execute("insert into user values (3014015015, 'yooo', default)");
			if(stmt != null)
				stmt.close();
		} catch(SQLException sqle) {
			System.out.println(sqle);
		} catch(ClassNotFoundException cnfe) {
			System.out.println(cnfe);
		}
	}

	@After
	public void tearDown() throws Exception {
		getInfo.release();
		try {
			Statement stmt = conn.createStatement();
			stmt.execute("delete from user where num=3014014014");
			stmt.execute("delete from user where num=3014015015");
			if(stmt != null)
				stmt.close();
			if(conn != null)
				conn.close();
		} catch(SQLException ex) {
			System.out.println(ex);
		}
	}

	@Test
	public void testGetUserInfo() {
		assertTrue(getInfo instanceof GetUserInfo);
	}
	
	@Test
	public void testRelease() {
		try {
			assertFalse(getInfo.conn.isClosed());
			getInfo.release();
			assertTrue(getInfo.conn.isClosed());
		} catch(SQLException ex) {
			System.out.println(ex);
		}
	}
	
	@Test
	public void testGetMail() {
		String mail = getInfo.getMail("3014014014");
		assertEquals(mail, "yoo@bili.com");
		mail = getInfo.getMail("3014015015");
		assertEquals(mail, "default@tilitili.com");
	}
	
	@Test
	public void testGetNickname() {
		String nname = getInfo.getNickname("3014014014");
		assertEquals(nname, "yoo");
		nname = getInfo.getNickname("3014015015");
		assertEquals(nname, "yooo");
	}
	
	@Test
	public void testAddUser() {
		getInfo.addUser("3014016016");
		String sqlRequest = "select * from user where num=3014016016";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sqlRequest);
			rs.next();
			assertEquals(rs.getString("num"), "3014016016");
			// System.out.println(rs.getString("nickname"));
			assertEquals(rs.getString("nickname"), "3014016016");
			assertEquals(rs.getString("mail"), null);
			rs.close();
			stmt.close();
		} catch(SQLException ex) {
			System.out.println(ex);
		}
	}
	
	@Test
	public void testUpdateInfo() {
		getInfo.updateInfo("3014015015", "y000", "y000@bili.com");
		String sqlRequest = "select * from user where num=3014015015";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs  =stmt.executeQuery(sqlRequest);
			rs.next();
			assertEquals(rs.getString("num"), "3014015015");
			assertEquals(rs.getString("nickname"), "y000");
			assertEquals(rs.getString("mail"), "y000@bili.com");
			rs.close();
			stmt.close();
		} catch(SQLException ex) {
			System.out.println(ex);
		}
	}
	
	@Test
	public void testIsAdmin() {
		boolean isAdmin = getInfo.isAdmin("3014014014");
		assertEquals(isAdmin, false);
		isAdmin = getInfo.isAdmin("2012011348");
		assertEquals(isAdmin, true);
	}

}

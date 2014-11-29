package test;

import static org.junit.Assert.*;
import video.Comment;

import java.sql.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

//测试前需要将Comment类中的rs、conn与stm私有成员暂时改成public属性，测试完记得改回去！
public class CommentTest {

	private Comment comment = null;
	private ResultSet rs;
	private Connection conn;
	private Statement stm;
	private String id;
	
	private void execute(String sql) {
		try {
			stm = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stm.executeQuery(sql);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	@Before
	public void setUp() throws Exception {
		comment = new Comment();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
			PreparedStatement pstmt1 = conn.prepareStatement("insert into video (title, path, icon, type, time, recent, click, praise, comment, nextcomment) values ('测试1', 'testvideo/1.flv', 'testimg/1.jpeg', 'entertainment', '2014-11-11 20:00', '2014-11-12 20:00', 10, 0, 1, 2)");
			pstmt1.executeUpdate();
			pstmt1.close();
			String sql = "select * from video order by id desc";
			execute(sql);
			rs.next();
			id = rs.getString("id");
			PreparedStatement pstmt2 = conn.prepareStatement("insert into comment (id, seq, content, time, authorid) values (?, '1', 'first', '2014-11-11 20:00', '1987654321')");
			pstmt2.setString(1, id);
			pstmt2.executeUpdate();
			pstmt2.close();
		} catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}

	@After
	public void tearDown() throws Exception {
		comment.release();
		PreparedStatement pstmt1 = conn.prepareStatement("delete from video where id = ?");
		pstmt1.setString(1, id);
		pstmt1.executeUpdate();
		pstmt1.close();
		PreparedStatement pstmt2 = conn.prepareStatement("delete from comment where id = ?");
		pstmt2.setString(1, id);
		pstmt2.executeUpdate();
		pstmt2.close();
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

	@Test
	public void testComment() {
		assertTrue(comment instanceof Comment);
	}

	@Test
	public void testNewComment() {
		comment.newComment(id, "2000-01-01 00:00:00.0", "have a test", "1234567890");
		String sql = "select * from comment where id=" + id + " order by seq desc";
		execute(sql);
		try {
			rs.next();
			assertEquals(rs.getString("id"), id);
			assertEquals(rs.getString("seq"), "2");
			assertEquals(rs.getString("content"), "have a test");
			assertEquals(rs.getString("time"), "2000-01-01 00:00:00.0");
			assertEquals(rs.getString("authorid"), "1234567890");
			PreparedStatement pstmt = conn.prepareStatement("delete from comment where id=? and seq=2");
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testGetNameByStuNum() {
		try {
			PreparedStatement pstmt1 = conn.prepareStatement("insert into user (num, nickname, mail) values ('1234567890', 'testor', '123@gmail.com')");
			pstmt1.executeUpdate();
			pstmt1.close();
			assertEquals("testor", comment.getNameByStuNum("1234567890"));
			assertEquals("", comment.getNameByStuNum("0"));
			PreparedStatement pstmt2 = conn.prepareStatement("delete from user where num = 1234567890");
			pstmt2.executeUpdate();
			pstmt2.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testGetCommentById() {
		comment.getCommentById(id);
		try {
			comment.rs.next();
			assertEquals(comment.rs.getString("id"), id);
			assertEquals(comment.rs.getString("seq"), "1");
			assertEquals(comment.rs.getString("content"), "first");
			assertEquals(comment.rs.getString("time"), "2014-11-11 20:00:00.0");
			assertEquals(comment.rs.getString("authorid"), "1987654321");
			assertFalse(comment.rs.next());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testGetRs() {
		assertEquals(null, comment.getRs());
	}

	@Test
	public void testRelease() {
		comment.getCommentById("1");
		try {
			assertFalse(comment.rs.isClosed());
			assertFalse(comment.conn.isClosed());
			assertFalse(comment.stm.isClosed());
			comment.release();
			assertTrue(comment.rs.isClosed());
			assertTrue(comment.conn.isClosed());
			assertTrue(comment.stm.isClosed());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}

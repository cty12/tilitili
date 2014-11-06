package video;

import java.sql.*;

/**用来控制首页的轮播设备*/
public class Slide {
	private ResultSet rs;
	private	Connection conn;
	private Statement stm;
	
	/**初始函数*/
	public Slide()
	{
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/tilitili", "root", "");
		}catch(ClassNotFoundException e) {
			System.out.println(e);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**改变某个图片的信息*/
	public void changeSlide(String path, String link, String replace)
	{
		try 
		{
			PreparedStatement pstmt = conn.prepareStatement("update carousel set path=?, link=? where id=?"); 
			pstmt.setString(1, path); 
			pstmt.setString(2, link);
			pstmt.setString(3, replace);  
			pstmt.executeUpdate(); 
			pstmt.close();
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**得到所有的图片信息*/
	public void getList()
	{
		String sql = "select * from carousel order by id";
		execute(sql);
	}
	
	/**执行语句*/
	private void execute(String sql)
	{
		try 
		{
			stm = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stm.executeQuery(sql);
		} catch(SQLException e) {
			System.out.println(e);
		}
	}
	
	/**得到Rs*/
	public ResultSet getRs() {
		return rs;
	}
	
	/**释放资源*/
	public void release() 
	{
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

package play;

import static org.junit.Assert.*;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class VideoInfoTest {

	private static VideoInfo videoInfo;

	@Before
	public void setUp() throws Exception {
		videoInfo = new VideoInfo();
	}

	@After
	public void tearDown() throws Exception {
		videoInfo.release();
	}

	@Test(timeout = 1000)
	public void testRelease() {
		videoInfo.release();
		videoInfo.release();
	}

	@Test(timeout = 1000)
	public void testGetVideoInfoById() throws SQLException {
		//输入不符合规范的id
		assertEquals(null, videoInfo.getVideoInfoById("a futile id"));
		//查找不存在的video
		assertEquals(null, videoInfo.getVideoInfoById("16"));
		
		//查找存在的video,验证相关信息的正确性
		String videoId = "9";
		ResultSet rs = videoInfo.getVideoInfoById(videoId);
		rs.last();
		assertEquals(1, rs.getRow()); //返回的结果集合记录数为1
		assertEquals(videoId, rs.getString("id")); //id应于指定的id一致
		assertEquals("Malaysia_Chabor", rs.getString("title"));
		rs.close();
	}

	@Test(timeout = 1000)
	public void testFindVideoByKeyDefault() throws SQLException {
		//搜索不到包含指定关键字的记录
		assertEquals(null, videoInfo.findVideoByKey("a_key"));
		//搜索输入含有非法字符
		assertEquals(null, videoInfo.findVideoByKey("."));
		
		//搜索记录检查
		String key = "测试";
		ResultSet rs1 = videoInfo.findVideoByKey(key);
		rs1.beforeFirst();
		int sum = 0;
		while (rs1.next()) {
			assertEquals(true, rs1.getString("title").contains(key)); //所有搜索结果标题必须包含相应关键字
			sum ++;
		}
		assertEquals(8, sum);
		rs1.close();
		
		//多个关键字时的搜索记录检查
		String keys = "7 4";
		ResultSet rs2 = videoInfo.findVideoByKey(keys);
		rs2.beforeFirst();
		sum = 0;
		while (rs2.next()) {
			assertEquals(true, rs2.getString("title").contains("4") |
					rs2.getString("title").contains("7")); //所有搜索结果标题必须包含相应关键字
			sum ++;
		}
		assertEquals(2, sum);
		rs2.close();
	}

	@Test(timeout = 1000)
	public void testFindVideoByKeyCondition() throws SQLException {
		//搜索不到包含指定关键字的记录
		assertEquals(null, videoInfo.findVideoByKey("a_key", null, null));
		//搜索输入含有非法字符
		assertEquals(null, videoInfo.findVideoByKey(".", ";", "|"));
		
		String key = "测试";
		String type = "entertainment";
		String order = "click";
		//搜索记录类型检查
		ResultSet rs1 = videoInfo.findVideoByKey(key, type, null);
		rs1.beforeFirst();
		int sum = 0;
		while (rs1.next()) {
			assertEquals(type, rs1.getString("type"));
			sum ++;
		}
		assertEquals(4, sum);
		rs1.close();
		
		//搜索记录排序检查
		ResultSet rs2 = videoInfo.findVideoByKey(key, null, order);
		rs2.first();
		int formerClick = rs2.getInt("click");
		while (rs2.next()) {
			int temp = rs2.getInt("click");
			assertEquals(true, formerClick >= temp);
			formerClick = temp;
		}
		rs2.close();
	}

}

package login;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

public class Login {
	public static boolean login(String studentid, String pwd) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL loginUrl = new URL("http://student.tsinghua.edu.cn/practiceLogin.do");
			String param = "userName=" + java.net.URLEncoder.encode(studentid, "utf-8") + "&password=" + java.net.URLEncoder.encode(pwd, "utf-8");
			// 打开和URL之间的连接
			URLConnection conn = loginUrl.openConnection();
			// 设置通用的请求属性
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e + "\n");
			e.printStackTrace();
		}
		//使用finally块来关闭输出流、输入流
		finally{
			try{
				if(out!=null) {
					out.close();
				}
				if(in!=null) {
					in.close();
				}
			}
			catch(IOException ex){
				ex.printStackTrace();
			}
		}
		if(result.equals("")) {
			return false;
        } else {
        	return true;
        }
	}
}

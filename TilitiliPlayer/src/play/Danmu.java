package play;

import common.Path;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;

public class Danmu {
	private String PATH = Path.WORKINGDIR + Path.DANMUREPO;
	private String filename;
	private String chatId;

	/**
	 * 构造函数，什么都不做
	 */
	public Danmu() {}
	
	/**
	 * 储存新获取的弹幕信息
	 * @param videoId 该条弹幕所属的视频id
	 * @param params 弹幕条目的参数
	 */
	public void saveDanmuInfoById(String videoId, String [] params) {
		chatId = videoId;
		String attrOfP = this.getAttributeStrOfP(params);
		String text = params[5];
		//创建DOM实例
		filename = "danmu" + videoId + ".xml";
		File xml = new File(PATH + filename);
		Document document = getDOM(xml);
		this.writeDanmuXML(xml, document);
		//添加新的弹幕条目标签
		document.getDocumentElement();
		Node nodeI = document.getElementsByTagName("i").item(0);
		Element elemD = document.createElement("d");
		elemD.setAttribute("p", attrOfP);
		elemD.setTextContent(text);
		nodeI.appendChild(elemD);
		//将文档树写入xml
		this.writeDanmuXML(xml, document);
	}

	/**
	 * 将弹幕信息转换为符合弹幕xml中属性p格式的字符串
	 * @param params 弹幕信息
	 * @return 符合格式的字符串
	 */
	private String getAttributeStrOfP(String [] params) {
		String attrOfP = "";
		try {
			Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(params[4]);
			for (int i = 0; i != params.length - 2; i ++)
				attrOfP += (params[i] + ",");
			attrOfP += Long.toString(date.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return attrOfP;
	}

	/**
	 * 获取DOM实例
	 * @param videoId 视频的ID
	 * @return 文档树的根
	 */
	private Document getDOM(File xml) {
		if (xml.exists())
			return rebuildDOM(xml);
		else
			return createNewDOM(xml);
	}

	/**
	 * 依据已有的xml文档创建文档树
	 * @param xml 文件路径
	 * @return 重建的文档树
	 */
	private Document rebuildDOM(File xml) {
		try {
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			FileInputStream fis = new FileInputStream(xml);
			return builder.parse(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 创建新的xml文档树
	 * @param xml 文件路径
	 * @return 新建的文档树
	 */
	private Document createNewDOM(File xml) {
		try {
			xml.createNewFile();
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document document = builder.newDocument();
			// 建立标签i
			Element elemI = document.createElement("i");
			// 添加chatserver标签
			Element chatserver = document.createElement("chatserver");
			chatserver.setTextContent("chat.tilitili.tv");
			elemI.appendChild(chatserver);
			// 添加chatid标签
			Element chatid = document.createElement("chatid");
			chatid.setTextContent(chatId);
			elemI.appendChild(chatid);
			//添加mission标签
			Element mission = document.createElement("mission");
			mission.setTextContent("0");
			elemI.appendChild(mission);
			//添加source标签
			Element source = document.createElement("source");
			source.setTextContent("k-v");
			elemI.appendChild(source);

			document.appendChild(elemI);
			return document;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	private void writeDanmuXML(File xml, Document document) {
		try {
			Transformer tf = TransformerFactory.newInstance().newTransformer();
			tf.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
			tf.setOutputProperty(OutputKeys.VERSION, "1.0");
			DOMSource ds = new DOMSource(document);
			StreamResult sr = new StreamResult(xml);
			tf.transform(ds, sr);
		} catch (TransformerConfigurationException
				| TransformerFactoryConfigurationError e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
		}
	}

}

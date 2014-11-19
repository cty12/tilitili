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
	 * ���캯����ʲô������
	 */
	public Danmu() {}
	
	/**
	 * �����»�ȡ�ĵ�Ļ��Ϣ
	 * @param videoId ������Ļ��������Ƶid
	 * @param params ��Ļ��Ŀ�Ĳ���
	 */
	public void saveDanmuInfoById(String videoId, String [] params) {
		chatId = videoId;
		String attrOfP = this.getAttributeStrOfP(params);
		String text = params[5];
		//����DOMʵ��
		filename = "danmu" + videoId + ".xml";
		File xml = new File(PATH + filename);
		Document document = getDOM(xml);
		this.writeDanmuXML(xml, document);
		//����µĵ�Ļ��Ŀ��ǩ
		document.getDocumentElement();
		Node nodeI = document.getElementsByTagName("i").item(0);
		Element elemD = document.createElement("d");
		elemD.setAttribute("p", attrOfP);
		elemD.setTextContent(text);
		nodeI.appendChild(elemD);
		//���ĵ���д��xml
		this.writeDanmuXML(xml, document);
	}

	/**
	 * ����Ļ��Ϣת��Ϊ���ϵ�Ļxml������p��ʽ���ַ���
	 * @param params ��Ļ��Ϣ
	 * @return ���ϸ�ʽ���ַ���
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
	 * ��ȡDOMʵ��
	 * @param videoId ��Ƶ��ID
	 * @return �ĵ����ĸ�
	 */
	private Document getDOM(File xml) {
		if (xml.exists())
			return rebuildDOM(xml);
		else
			return createNewDOM(xml);
	}

	/**
	 * �������е�xml�ĵ������ĵ���
	 * @param xml �ļ�·��
	 * @return �ؽ����ĵ���
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
	 * �����µ�xml�ĵ���
	 * @param xml �ļ�·��
	 * @return �½����ĵ���
	 */
	private Document createNewDOM(File xml) {
		try {
			xml.createNewFile();
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document document = builder.newDocument();
			// ������ǩi
			Element elemI = document.createElement("i");
			// ���chatserver��ǩ
			Element chatserver = document.createElement("chatserver");
			chatserver.setTextContent("chat.tilitili.tv");
			elemI.appendChild(chatserver);
			// ���chatid��ǩ
			Element chatid = document.createElement("chatid");
			chatid.setTextContent(chatId);
			elemI.appendChild(chatid);
			//���mission��ǩ
			Element mission = document.createElement("mission");
			mission.setTextContent("0");
			elemI.appendChild(mission);
			//���source��ǩ
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

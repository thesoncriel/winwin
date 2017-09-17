<%@page import="javax.xml.transform.stream.StreamResult,
	javax.xml.transform.dom.DOMSource,
	javax.xml.transform.*,
	java.util.*,
	javax.xml.parsers.*,
	org.w3c.dom.*,
	java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
public String toKor(String value){
	try{
		return new String(value.getBytes("8859_1"), "utf-8");
	}
	catch(UnsupportedEncodingException ex){
		return null;
	}
}
public String toKor2(String value){
	try{
		return new String(new String(value.getBytes("KSC5601"), "8859_1").getBytes("8859_1"), "utf-8");
	}
	catch(UnsupportedEncodingException ex){
		return null;
	}
}
public void removeChildByContentID(Document doc, String id){
	NodeList nodeList = doc.getElementsByTagName("contentID");
	Node notices = doc.getElementsByTagName("notices").item(0);
	Node contentId = null;
	
	for(int i = 0; i < nodeList.getLength(); i++){
		contentId = nodeList.item(i);
		if(contentId.getAttributes().getNamedItem("contentID").getNodeValue().equals(id) == true){
			notices.removeChild(contentId.getParentNode());
		}
	}
}
%>
<%
	if (request.getParameter("write") != null){
		Calendar cal = Calendar.getInstance();
		String sDate = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1) + "-" + cal.get(Calendar.DAY_OF_MONTH);
		Map<String, String[]> paraMap = request.getParameterMap();
%>			
			<form id="form_Notice" action="controller/noticefix_controller.jsp" method="get">
				<fieldset>
				    <!-- 톱니바퀴 클릭 시 value에 해당 게시물 ID값을 설정 해 줘야 한다. -->
					<input type="text" name="contentID" value="<%=paraMap.get("contentID")[0] %>" />
					<input type="text" name="type" value="<%=toKor(paraMap.get("type")[0]) %>" />
					<input type="text" name="subject" value="<%=toKor(paraMap.get("subject")[0]) %>" />
					<input type="text" name="href" value="<%=paraMap.get("href")[0] %>" />
					<input type="text" name="file" value="<%=paraMap.get("file")[0] %>" />
					<input type="text" name="date" value="<%=paraMap.get("date")[0] %>" />
					<input id="checkBox_NoticeFixEnable" type="checkbox" name="notice_fix" value="true" />공지사항 고정 적용<br />
					시작일<input id="calendar_Start" type="text" value="<%=paraMap.get("date")[0] %>" name="sdate" /><br />
					종료일<input id="calendar_End" type="text" value="<%=sDate %>" name="edate" /><br />
					<input id="button_NoticeSubmit" type="submit" value="적용" /><br />
					<a href="#" id="notice_close">X</a>
					
				</fieldset>
			</form>
			<div id="backgroundPopup"> </div>
<%
		return;
	}


try{
	Document doc = null;
	Element notices = null;
	Element notice = null;
	Element _contentID = null;
	Element _type = null;
	Element _subject = null;
	Element _file = null;
	Element _date = null;
	Element duplicate = null;
	
	
	boolean isRead = (request.getParameter("read") != null);
	String sNoticeFix = request.getParameter("notice_fix");
	Map<String, String[]> paraMap = request.getParameterMap();
	File xmlFile = new File(getServletContext().getRealPath("config/noticeFix.xml"));
	
	DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
	docFactory.setIgnoringElementContentWhitespace(true);
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	
	// 공지사항 고정 내역 xml파일을 만든다.
	// 만약 파일이 존재 하지 않는다면 내부적으로 xml 문서를 생성 한다.
	if (xmlFile.exists() == false){
		doc = docBuilder.newDocument();
		Element root = doc.createElement("noticeFix");
		notices = doc.createElement("notices");
		root.appendChild(notices);
		doc.appendChild(root);
	}
	// 존재한다면 기존 문서를 파싱하여 가져 온다.
	else{
		doc = docBuilder.parse(xmlFile);
		notices = (Element)doc.getElementsByTagName("notices").item(0);
	}
	
	ArrayList<Map<String, String>> noticeMapList = new ArrayList<Map<String, String>>();
	NodeList nodeList = null;
	Map<String, String> map = null;
	NodeList noticeChilds = null;
	if (isRead == true){
		if (notices.hasChildNodes() == true){
			nodeList = notices.getChildNodes(); 
			for(int i = 1; i < nodeList.getLength(); i+=2){
				noticeChilds = nodeList.item(i).getChildNodes();
				map = new HashMap<String, String>();
				map.put("contentID", noticeChilds.item(1).getAttributes().getNamedItem("contentID").getNodeValue());
				map.put("type", noticeChilds.item(3).getAttributes().getNamedItem("type").getNodeValue());
				map.put("subject", noticeChilds.item(5).getAttributes().getNamedItem("subject").getNodeValue());
				map.put("isnew", noticeChilds.item(5).getAttributes().getNamedItem("isnew").getNodeValue());
				map.put("href", noticeChilds.item(5).getAttributes().getNamedItem("href").getNodeValue());
				map.put("file", noticeChilds.item(7).getAttributes().getNamedItem("file").getNodeValue());
				map.put("date", noticeChilds.item(9).getAttributes().getNamedItem("date").getNodeValue());
				map.put("sdate", noticeChilds.item(9).getAttributes().getNamedItem("sdate").getNodeValue());
				map.put("edate", noticeChilds.item(9).getAttributes().getNamedItem("edate").getNodeValue());
				noticeMapList.add(map);
			}
		}
		session.setAttribute("noticeMapList", noticeMapList);
		out.println("");
		return;
	}
	
	
	// notice_fix 값이 null 이면 해당 항목을 삭제 하라는 의미이다.
	removeChildByContentID(doc, paraMap.get("contentID")[0]);
	if (sNoticeFix == null){
		
	}
	// null이 아니면 추가의 의미 이다.
	else{
		// 노드 추가 전 같은 id로 이미 존재 할 경우 미리 삭제 한다.
/* 		out.println(duplicate == null);
		out.println(notices.getChildNodes().getLength() + "");
		out.println(paraMap.get("type")[0]);
		out.println(paraMap.get("subject")[0]);
		out.println(toKor(paraMap.get("type")[0]));
		out.println(toKor(paraMap.get("subject")[0]));
		out.println(toKor2(paraMap.get("type")[0]));
		out.println(toKor2(paraMap.get("subject")[0])); */
		
		notice = doc.createElement("notice");
		notice.setAttribute("ID", paraMap.get("contentID")[0]);
		_contentID = doc.createElement("contentID");
		_contentID.setAttribute("contentID", paraMap.get("contentID")[0]);
		_type = doc.createElement("type");
		_type.setAttribute("type", toKor(paraMap.get("type")[0]));
		_subject = doc.createElement("subject");
		_subject.setAttribute("subject", toKor(paraMap.get("subject")[0]));
		_subject.setAttribute("isnew", "true");
		_subject.setAttribute("href", paraMap.get("href")[0]);
		_file = doc.createElement("file");
		_file.setAttribute("file", paraMap.get("file")[0]);
		//_file.setAttribute("ext", paraMap.get("file_ext")[0]);
		_date = doc.createElement("date");
		_date.setAttribute("date", paraMap.get("date")[0]);
		_date.setAttribute("sdate", paraMap.get("sdate")[0]);
		_date.setAttribute("edate", paraMap.get("edate")[0]);
		
		notice.appendChild(_contentID);
		notice.appendChild(_type);
		notice.appendChild(_subject);
		notice.appendChild(_file);
		notice.appendChild(_date);
		
		// 데이터는 최대 5개까지 수용 한다. 곧 하나를 추가 할 것이므로 이미 5개가 되어 있다면 마지막 것을 삭제 한다.
		if (notices.getChildNodes().getLength() == 5){
			notices.removeChild(notices.getLastChild());
		}
		// 지난번 공지사항 자료의 New 마크를 없앤다.
		if (notices.getChildNodes().getLength() > 1){
			if (notices.getChildNodes().item(1).equals(doc.getElementById(paraMap.get("contentID")[0])) == false){
				notices.getChildNodes().item(1).getChildNodes().item(5).getAttributes().getNamedItem("isnew").setNodeValue("false");
			}
		}
		// 새로이 추가한 내용은 항상 가장 윗단에 둔다.
		notices.insertBefore(notice, notices.getFirstChild());
	}
	
	// 작업 완료 후 xml 파일을 저장 한다.
	TransformerFactory transformerFactory = TransformerFactory.newInstance();
	Transformer transformer = transformerFactory.newTransformer();
	transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
	transformer.setOutputProperty(OutputKeys.INDENT, "yes");
	DOMSource source = new DOMSource(doc);
	FileOutputStream fos = new FileOutputStream(xmlFile);
	StreamResult result = new StreamResult(fos);
	transformer.transform(source, result);
	
}
catch(DOMException ex){
	out.println(ex.getMessage());
}
catch(IOException ex){
	out.println(ex.getMessage());
}

response.sendRedirect("../forum.jsp?view=sub_2_1_1");

%>

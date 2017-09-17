<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.net.URLEncoder, java.util.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="css/topmenu.css" />
		<link rel="stylesheet" type="text/css" href="css/leftmenu.css" />
		<link rel="stylesheet" type="text/css" href="css/footer.css" />
		<link rel="stylesheet" type="text/css" href="css/forum.css" />
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
		<link rel="stylesheet" type="text/css" href="css/sliderkit-core.css" />
		<link rel="stylesheet" type="text/css" href="css/sliderkit-demos.css" />
		<link rel="stylesheet" type="text/css" href="css/popup_config.css" />
		<link rel="stylesheet" type="text/css" href="css/popup.css" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.easing.1.3.min.js"></script>
		<script type="text/javascript" src="js/jquery.mousewheel.min.js"></script>
		<script type="text/javascript" src="js/jquery.sliderkit.1.9.2.pack.js"></script>
		<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/topmenu.js"></script>
		<script type="text/javascript" src="js/forum.js"></script>
		<script type="text/javascript" src="js/jquery.form.js"></script>
		<script type="text/javascript" src="js/popup.js"></script>
	</head>
	<body class="viewpage">
		<div id="page_wrap">
<%
String sView = "comtnews";//request.getParameter("view");
String sCont = request.getParameter("cont");
pageContext.include("viewpart/topmenu.htmlpart");
%>
			<div id="content_wrap">
<%
pageContext.include("viewpart/leftmenu.jsp?view=" + sView);
//pageContext.include("../controller/noticefix_controller.js?read=true);
%>
			
<jsp:include page="controller/noticefix_controller.jsp">
<jsp:param name="read" value="true" />
</jsp:include>
<div id="popup_config">
<%
request.setCharacterEncoding("UTF-8");
String sTitle = request.getParameter("title");
String sImg = request.getParameter("img");

if (sTitle == null){
	sTitle = "";
	sImg = "";
}
else{
	sTitle = toKor(sTitle);
	sImg = "http://www.winwingrowth.or.kr/upload/popup/120810_popup.gif";
}


%>
			<h2>팝업 생성 및 수정</h2>
			<form id="form_PopupConfig" action="" >
				<fieldset>
					<ul>
						<li>
							<label>제목</label>
							<p>
								<input id="textBox_Title" type="text" name="title" value="<%=sTitle %>"/>
							</p>
						</li>
						<li class="form_2cols">
							<label>공지시작일</label>
							<p>
								<input id="calendar_DateStart" type="text" name="sdate" value="2012-09-01" />
							</p>
		
							<label>공지종료일</label>
							<p>
								<input id="calendar_DateEnd" type="text" name="edate" value="2012-09-30" />
							</p>
						</li>
						<li class="form_2cols">
							<label>가로길이</label>
							<p>
								<input id="textBox_Width" type="text" name="width" value="330" />
							</p>
		
							<label>세로길이</label>
							<p>
								<input id="textBox_Height" type="text" name="height" value="300" />
							</p>
						</li>
						<li>
							<label>쿠키생성여부</label>
							<p>
								하루동안 이창을 열지 않음 사용 : 
								<input id="radioBox_CookieYes" type="radio" name="cookie" checked="checked" />예
								<input id="radioBox_CookieNo" type="radio" name="cookie" />아니오
							</p>
						</li>
						<li>
							<label>팝업콜여부</label>
							<p>
								팝업존에만 표시 : 
								<input id="radioBox_CallYes" type="radio" name="call" checked="checked" />예
								<input id="radioBox_CallNo" type="radio" name="call" />아니오
							</p>
						</li>
						<li>
							
						</li>
						<li>
							<label>링크경로</label>
							<p>
								<input id="textBox_LinkPath" type="text" name="linkPath" />
							</p>
						</li>
					</ul>
					<p class="controls_bottom">
						<a href="" id="button_PopupConfigCancel">취소</a>
						<!--  <input id="button_PopupConfigOK" type="submit" value="확인" /> -->
						<a href="popup_config.jsp?title=팝업테스트&img=D:/00시연용이미지/120810_popup.gif" id="button_PopupConfigOK">확인</a>
					</p>
					<input id="isconfig" type="hidden" value="true" />
				</fieldset>
			</form>
			<form id="form_ImgUpload" action="controller/file_uploader.jsp" method="post" enctype="multipart/form-data">
								<fieldset>
									<label>이미지</label>
									<p>
										<input id="fileBox_Image" type="file" name="imgFile" value="파일선택" />
									</p>
								</fieldset>
							</form>
			<div id="popupContact">
	        	<h2 id="popup_title"><%=sTitle %></h2>
	        	
	        	<a id="popup_link" href="http://www.skbt.co.kr"><img src="<%=sImg %>" alt="팝업 이미지" /></a>
	        	<p id="contactArea">
	        		
	        	</p>
	        	<a id="popupContactClose">x</a>
	        	<span id="neverOpenOnDay"><input id="checkBox_neverOpenOnDay" type="checkbox" />오늘 하루동안 보이지 않기</span>
	        </div>
	        <div id="backgroundPopup"> </div>
        </div>
			</div>
<% pageContext.include("viewpart/footer.htmlpart"); %>
		</div>
	</body>
</html>
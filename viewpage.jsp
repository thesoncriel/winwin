<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="css/topmenu.css" />
		<link rel="stylesheet" type="text/css" href="css/leftmenu.css" />
		<link rel="stylesheet" type="text/css" href="css/footer.css" />
		<link rel="stylesheet" type="text/css" href="css/sliderkit-core.css" />
		<link rel="stylesheet" type="text/css" href="css/sliderkit-demos.css" />
		<link rel="stylesheet" type="text/css" href="css/substyle.css" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.easing.1.3.min.js"></script>
		<script type="text/javascript" src="js/jquery.mousewheel.min.js"></script>
		<script type="text/javascript" src="js/jquery.sliderkit.1.9.2.pack.js"></script>
		<script type="text/javascript" src="js/topmenu.js"></script>
	</head>
	<body class="viewpage">
		<div id="page_wrap">
<%
String sView = request.getParameter("view");
pageContext.include("viewpart/topmenu.htmlpart");
%>
			<div id="content_wrap">
<%
pageContext.include("viewpart/leftmenu.jsp?view=" + sView); 
%>
			
<% pageContext.include("viewpart/content.jsp?view=" + sView); %>				
			</div>
<% pageContext.include("viewpart/footer.htmlpart"); %>
		</div>
	</body>
</html>
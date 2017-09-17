<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String sView = request.getParameter("view");
if		(sView.startsWith("sub_1") == true) pageContext.include("leftmenu/menu1.htmlpart");
else if	(sView.startsWith("sub_2") == true) pageContext.include("leftmenu/menu2.htmlpart");
else if	(sView.startsWith("sub_3") == true) pageContext.include("leftmenu/menu3.htmlpart");
else if (sView.startsWith("sub_4") == true) pageContext.include("leftmenu/menu4.htmlpart");
else if (sView.startsWith("sub_5") == true) pageContext.include("leftmenu/menu5.htmlpart");
%>
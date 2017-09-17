<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String sView = request.getParameter("view");

if 		(sView.equals("forum") == true)	pageContext.include("content/forum.htmlpart");
else if (sView.startsWith("sub"))		pageContext.include("content/" + sView + ".htmlpart");
else{
	out.println("");
}
%>
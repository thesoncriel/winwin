<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.apache.commons.fileupload.MultipartStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
String sUploadPath = getServletContext().getRealPath("upload/popup/");
int iSize = 10 * 1024 * 1024;


try{
	MultipartRequest multiRequest = new MultipartRequest(request, sUploadPath, iSize, "euc-kr", new DefaultFileRenamePolicy());
	Enumeration emFile = multiRequest.getFileNames();
	String sName = multiRequest.getFilesystemName((String)emFile.nextElement());
	out.println("'upload/popup/" + sName + "'");
}
catch(Exception ex){
	out.println(ex.toString());
}

%>
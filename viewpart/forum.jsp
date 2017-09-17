<%@page import="java.net.URLEncoder, java.util.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
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
		<link rel="stylesheet" type="text/css" href="css/forum.css" />
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" media="all" />
		<link rel="stylesheet" type="text/css" href="css/sliderkit-core.css" />
		<link rel="stylesheet" type="text/css" href="css/sliderkit-demos.css" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="js/jquery.easing.1.3.min.js"></script>
		<script type="text/javascript" src="js/jquery.mousewheel.min.js"></script>
		<script type="text/javascript" src="js/jquery.sliderkit.1.9.2.pack.js"></script>
		<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/topmenu.js"></script>
		<script type="text/javascript" src="js/forum.js"></script>
	</head>
	<body class="viewpage">
		<div id="page_wrap">
<%
String sView = request.getParameter("view");
pageContext.include("viewpart/topmenu.htmlpart");
%>
			<div id="content_wrap">
<%
if (sView != null){
	pageContext.include("viewpart/leftmenu.jsp?view=" + sView);
}
//pageContext.include("../controller/noticefix_controller.js?read=true);
%>
			
<jsp:include page="controller/noticefix_controller.jsp">
<jsp:param name="read" value="true" />
</jsp:include>
				<div id="forum">
					<form id="form_forum" action="">
					    <fieldset>
		        			<table>
		        				<caption>공지사항</caption>
		        				<thead>
		        					<tr>
		        						<th class="config"><input id="checkBox_allCheck" type="checkbox" /></th>
		        						<th class="config"> </th>
		        						<th class="number">번호</th>
		        						<th class="type">구분</th>
		        						<th class="subject">제목</th>
		        						<th class="file">첨부</th>
		        						<th class="date">등록일</th>
		        					</tr>
		        				</thead>
		        				<tbody>
		        				<%
			ArrayList<Map<String, String>> noticeList = (ArrayList<Map<String, String>>)session.getAttribute("noticeMapList");		        				
			for(Map<String, String> notice : noticeList){     				
		        				%>
		        					<tr class="notice_fix">
		        						<td>
		        							<input type="hidden" name="contentID" value="<%=notice.get("contentID") %>" />
		        							<input type="hidden" name="sdate" value="<%=notice.get("sdate") %>" />
		        							<input type="hidden" name="edate" value="<%=notice.get("edate") %>" />
		        						</td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="type_notice"><%=notice.get("type") %></td>
		        	                    <td class="subject_notice" colspan="2">
		        	                    	<a href="<%=notice.get("href") %>"><%=notice.get("subject") %></a> <% if (notice.get("isnew") == "true"){ %><strong class="new">New</strong><%} %>
		        	                    </td>
		        	                    <td class="file"><%=notice.get("file") %></td>
		        	                    <td class="date"><%=notice.get("date") %></td>
		                            </tr>
		       					<% 
			}
		       					%>
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="11" /></td>
		        						<!-- noticefix_controller.jsp?write=true&contentID=11&type=기타&href=http://www.skbt.co.kr&subject=<%=("대.중소기업 동반성장 토론회 개최 자료").replace(' ', '+') %>&file=pdf&date=2012-08-30 -->
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">67</td>
		        	                    <td class="type">기타</td>
		        	                    <td class="subject">
		        	                    	<a href="#">대.중소기업 동반성장 토론회 개최 자료</a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-08-30</td>
		                            </tr>
		                        	<tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="12" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">66</td>
		        	                    <td class="type">사업공고 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">2012년 대.중소기업 동반성장 유공 정부포상 후보 공개검증 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-08-14</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="13" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">65</td>
		        	                    <td class="type">사업공고 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">2012 동반성장주간 대행사 선정 공고 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-08-13</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="14" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">64</td>
		        	                    <td class="type">행사안내 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">대․중소기업 동반성장 토론회 개최 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-08-09</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="15" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">63</td>
		        	                    <td class="type">사업공고 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">중소기업 적합업종 전담 실태조사 기관 선정 공고 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-08-09</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="16" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">62</td>
		        	                    <td class="type">사업공고 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">전문인력 유출 심의위원회 분쟁조정 신청안내 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-07-25</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="17" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">61</td>
		        	                    <td class="type">사업공고 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">서비스업 중소기업 적합업종·품목지정 절차 및 신청양식 안내 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-07-23</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="18" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">60</td>
		        	                    <td class="type">기타</td>
		        	                    <td class="subject">
		        	                    	<a href="#">서비스업 적합업종 공청회 인사말씀 및 발표자료 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-07-04</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="19" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">59</td>
		        	                    <td class="type">사업공고 </td>
		        	                    <td class="subject">
		        	                    	<a href="#">2012년 동반성장 포상공고 </a> 
		        	                    </td>
		        	                    <td class="file">pdf</td>
		        	                    <td class="date">2012-06-05</td>
		                            </tr>
		                            
		                            <tr>
		        						<td><input class="forum_tbl_chk" type="checkbox" value="20" /></td>
		        						<td><a href="#" class="notice_config">설정</a></td>
		        	                    <td class="number">58</td>
		        	                    <td class="type">기타</td>
		        	                    <td class="subject">
		        	                    	<a href="#">동반성장 정책개발 아이디어 공모전 결과 안내 </a> 
		        	                    </td>
		        	                    <td> </td>
		        	                    <td class="date">2012-05-31</td>
		                            </tr>
		        				</tbody>
		        			</table>
		        			<div id="page_control">
		        			    <a id="first_page" href="#">&lt;&lt;</a>
		        			    <a id="prev_page" href="#">&lt;</a>
		        			    <a class="page_num_curr page_num_1st" href="#">01</a>
		        			    <a class="page_num" href="#">02</a>
		        			    <a class="page_num" href="#">03</a>
		        			    <a class="page_num" href="#">04</a>
		        			    <a class="page_num" href="#">05</a>
		        			    <a class="page_num" href="#">06</a>
		        			    <a class="page_num" href="#">07</a>
		        			    <a class="page_num" href="#">08</a>
		        			    <a class="page_num" href="#">09</a>
		        			    <a class="page_num" href="#">10</a>
		        			    <a id="next_page" href="#">&gt;</a>
		        			    <a id="last_page" href="#">&gt;&gt;</a>
		        			    <input id="button_deleteSubmit" type="submit" value="삭제" />
		        			    <a id="writing" href="#">글쓰기</a>
		        			</div>
		    			</fieldset>
					</form>
					
					<form id="search_control" action="">
						<fieldset>
						    <select id="comboBox_type">
						        <option selected="selected">전체</option>
						        <option>제목</option>
						        <option>내용</option>
						    </select>
						    <input id="textBox_keyword" type="text" />
						    <input id="button_search" type="submit" value="검색" />
					    </fieldset>
					</form>
					<form id="form_Notice" action="controller/noticefix_controller.jsp">
						<fieldset>
						    <!-- 톱니바퀴 클릭 시 value에 해당 게시물 ID값을 설정 해 줘야 한다. -->
							<input type="hidden" name="contentID" value="" />
							<input type="hidden" name="type" value="" />
							<input type="hidden" name="subject" value="" />
							<input type="hidden" name="href" value="" />
							<input type="hidden" name="file" value="" />
							<input type="hidden" name="date" value="" />
							<input id="checkBox_NoticeFixEnable" type="checkbox" name="notice_fix" value="true" />공지사항 고정 적용<br />
							시작일<input id="calendar_Start" type="text" value="2012-09-13" name="sdate" /><br />
							종료일<input id="calendar_End" type="text" value="2012-09-14" name="edate" /><br />
							<input id="button_NoticeSubmit" type="submit" value="적용" /><br />
							<a href="#" id="notice_close">X</a>
							
						</fieldset>
					</form>
			<div id="backgroundPopup"> </div>
				</div>
			</div>
<% pageContext.include("viewpart/footer.htmlpart"); %>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출 : noticeList
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	int noticeCnt = noticeDao.selectNoticeCount();
	int lastPage = noticeCnt / rowPerPage;
	
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/admin/noticeList.jsp">공지관리</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">멤버관리</a></li> <!-- 목록, 레벨수정, 강제탈퇴-->
			</ul>
		</div>
		<div>
			<!-- noticeList contents -->
			<h1>공지</h1>
			<a href="">공지입력</a>
			<table>
				<tr>
					<th>공지내용</th>
					<th>공지날짜</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<tr>
				<%
					for(Notice n : list) {
				%>
						<td><%=n.getNoticeMemo() %></td>
						<td><%=n.getCreatedate() %></td>
						<td>수정</td>
						<td>삭제</td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>
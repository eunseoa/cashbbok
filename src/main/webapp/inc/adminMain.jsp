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
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// Model 호출
	// 최근 공지 5개, 최근 멤버 5명
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// 최근 공지
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// 최근 멤버
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberByPage(beginRow, rowPerPage);
	
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
				<li><a href="<%=request.getContextPath() %>/admin/helpListAll.jsp">고객센터</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li>
				<li><a href="<%=request.getContextPath() %>/admin/memberList.jsp">멤버관리</a></li> <!-- 목록, 레벨수정, 강제탈퇴-->
			</ul>
		</div>
		<div>
			<h3>최근 가입회원</h3>
			<table>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>level</th>
				</tr>
				<tr>
				<%
					for(Member m : memberList) {
				%>
						<td><%=m.getMemberId() %></td>
						<td><%=m.getMemberName() %></td>
						<td><%=m.getMemberLevel() %></td>
						</tr><tr>
				<%
					}
				%>
			</table>
		</div>
		<div>
			<h3>최근 공지</h3>
			<table>
				<tr>
					<th>번호</th>
					<th>내용</th>
					<th>작성일자</th>
				</tr>
				<tr>
				<%
					for(Notice n : noticeList) {
				%>
						<td><%=n.getNoticeNo() %></td>
						<td><%=n.getNoticeMemo() %></td>
						<td><%=n.getCreatedate() %></td>
						</tr><tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>
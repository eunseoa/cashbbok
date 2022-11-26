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
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberByPage(beginRow, rowPerPage);
	
	int memberCnt = memberDao.selectMembetCount();
	
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
			<!-- memberList contents -->
			<h1>멤버목록</h1>
			<table>
				<tr>
					<th>멤버번호</th>
					<th>아이디</th>
					<th>레벨</th>
					<th>이름</th>
					<th>마지막수정일자</th>
					<th>생성일자</th>
					<th>레벨수정</th>
					<th>깅제탈퇴</th>
				</tr>
				<tr>
				<%
					for(Member m : list) {
				%>
						<td><%=m.getMemberNo() %></td>
						<td><%=m.getMemberId() %></td>
						<%
							if(m.getMemberLevel() == 1) {
						%>
								<td>관리자</td>
						<%
							} else {
						%>
								<td>일반회원</td>
						<%
							}
						%>
						<td><%=m.getMemberName() %></td>
						<td><%=m.getUpdatedate() %></td>
						<td><%=m.getCreatedate() %></td>
						<td>수정</td>
						<td>
							<a href="<%=request.getContextPath() %>/admin/deleteMemberByAdmin.jsp">강제탈퇴</a>
						</td>
						</tr><tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>
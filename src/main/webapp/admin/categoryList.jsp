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
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListbyAdmin();
	
	// 최근 공지 5개, 최근 멤버 5명 보여줌
	
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
			<!-- categoryList contents -->
			<h1>카테고리 목록</h1>
			<a href="<%=request.getContextPath() %>/admin/insertCategoryForm.jsp">카테고리 추가</a>
			<table>
				<tr>
					<th>번호</th>
					<th>수입/지출</th>
					<th>이름</th>
					<th>마지막 수정 날짜</th>
					<th>생성 날짜</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<tr>
				<%
					for(Category c : categoryList) {
				%>
						<td><%=c.getCategoryNo() %></td>
						<td><%=c.getCategoryKind() %></td>
						<td><%=c.getCategoryName() %></td>
						<td><%=c.getUpdatedate() %></td>
						<td><%=c.getCreatedate() %></td>
						<td><a href="<%=request.getContextPath() %>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo() %>">수정</a></td>
						<td><a href="<%=request.getContextPath() %>/admin/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo() %>">삭제</a></td>
						</tr><tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>
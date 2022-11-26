<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	} 
	
	// Model 호출
	
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
		</div>
	</body>
</html>
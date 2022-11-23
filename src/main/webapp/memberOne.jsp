<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//세션에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%=loginMember.getMemberName() %>님, 반갑습니다.
		<table>
			<tr>
				<th>아이디</th>
				<td><%=loginMember.getMemberId() %></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><%=loginMember.getMemberName() %></td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="<%=request.getContextPath() %>/updateMemberForm.jsp">정보 수정</a>
					<a href="">회원 탈퇴</a>
				</td>
			</tr>
		</table>
	</body>
</html>
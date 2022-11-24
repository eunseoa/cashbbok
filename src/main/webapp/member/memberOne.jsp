<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/member/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	
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
		<a href="<%=request.getContextPath() %>/cash/cashList.jsp">되돌아가기</a>
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
					<a href="<%=request.getContextPath() %>/member/updateMemberForm.jsp">정보 수정</a>
					<a href="<%=request.getContextPath() %>/member/deleteMemberForm.jsp">회원 탈퇴</a>
				</td>
			</tr>
		</table>
	</body>
</html>
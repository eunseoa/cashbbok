<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/updateMemberAction.jsp" method="post">
				<table>
					<tr>
						<td><input type="text" name="memberId" value="<%=loginMember.getMemberId() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td><input type="text" name="memberName" value="<%=loginMember.getMemberName() %>"></td>
					</tr>
					<tr>
						<td><input type="password" name="memberPw"></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
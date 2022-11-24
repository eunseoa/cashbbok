<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/member/insertLoginAction.jsp" method="post">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="memberId"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="memberPw"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="memberName"></td>
					</tr>
				</table>
				<button type="submit">회원가입</button>
			</form>
		</div>
	</body>
</html>
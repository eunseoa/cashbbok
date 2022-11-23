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
		<title>loginForm</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/loginAction.jsp" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="memberId">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="memberPw">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit">로그인</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
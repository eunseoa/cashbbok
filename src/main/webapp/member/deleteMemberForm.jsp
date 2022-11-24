<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/member/deleteMemberAction.jsp">
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="memberId" value="" readonly="readonly"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="memberPw"></td>
					</tr>
				</table>
				<button type="submit">탈퇴</button>
			</form>
		</div>
	</body>
</html>
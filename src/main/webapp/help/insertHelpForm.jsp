<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
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
			<form action="<%=request.getContextPath() %>/help/insertHelpAction.jsp" method="post">
				<table>
					<tr>
						<td><input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>"></td>
						<td>문의 내용</td>
						<td><textarea name="helpMemo"></textarea></td>
					</tr>
				</table>
				<button type="submit">등록</button>
			</form>
		</div>
	</body>
</html>
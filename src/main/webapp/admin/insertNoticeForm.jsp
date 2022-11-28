<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
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
		<form action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp" method="post">
			<div>
				<table>
					<tr>
						<th>내용</th>
					</tr>
					<tr>
						<td>
							<textarea name="noticeMemo"></textarea>
						</td>
					</tr>
				</table>
				<button type="submit">등록</button>
			</div>
		</form>
	</body>
</html>
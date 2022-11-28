<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	CategoryDao categoryDao = new CategoryDao();
	Category category = new Category();
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp" method="post">
				<table>
					<tr>
						<td>categoryKind</td>
						<td>
							<input type="radio" name="categoryKind" value="수입">수입
							<input type="radio" name="categoryKind" value="지출">지출
						</td>
					</tr>
					<tr>
						<td>categoryName</td>
						<td>
							<input type="text" name="categoryName">
						</td>
					</tr>
				</table>
				<button type="submit">추가</button>
			</form>
		</div>
	</body>
</html>
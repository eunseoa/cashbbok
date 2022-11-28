<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 접근금지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	System.out.println(categoryNo);
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	Category category = categoryDao.selectCategoryOne(categoryNo);
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/admin/updateCategoryAction.jsp" method="post">
				<table>
					<tr>
						<td>categoryNo</td>
						<td><input type="text" name="categoryNo" value="<%=category.getCategoryNo() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>categoryName</td>
						<td><input type="text" name="categoryName" value="<%=category.getCategoryName() %>"></td>
					</tr>
				</table>
				<button type="submit">수정</button>
			</form>
		</div>
	</body>
</html>
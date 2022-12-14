<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 수정할 카테고리의 정보가 넘어오지않았을때
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")
		|| request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		out.println("<script>alert(''); location.href='" + request.getContextPath() + "/admin/category/updateCategoryForm.jsp?" + "';</script>");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	
	// Meodel 호출
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category);
	
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath() + "/admin/category/categoryList.jsp");
		return;
	} else {
		System.out.println("수정실패");
		out.println("<script>alert('카테고리 수정 실패'); location.href='" + request.getContextPath() + "/admin/categoryList.jsp" + "';</script>");
		return;
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 접근금지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String categoryName = request.getParameter("categoryName");
	
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/category/updateCategoryForm.jsp?categoryNo=" + categoryNo);
		return;
	}
	
	// Meodel 호출
	Category category = new Category();
	category.setCategoryNo(categoryNo);
	category.setCategoryName(categoryName);
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.updateCategoryName(category);
	
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	} else {
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
%>
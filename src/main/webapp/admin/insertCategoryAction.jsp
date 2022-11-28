<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	// Model 호출
	Category category = new Category();
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);
	
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.insertCategroy(category);
	
	if(row == 1) {
		System.out.println("추가 성공");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	} else {
		System.out.println("추가 실패");
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
%>
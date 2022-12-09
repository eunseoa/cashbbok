<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	// Model
	CategoryDao categoryDao = new CategoryDao();
	int row = categoryDao.deleteCategory(categoryNo);
	
	if(row == 1) {
		System.out.println("카테고리 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");
	} else {
		System.out.println("카테고리 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/admin/category/categoryList.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 등록할 카테고리의 정보가 넘어오지않았을때
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null
		|| request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")) {
		out.println("<script>alert('입력되지않은 항목이 있습니다'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
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
		response.sendRedirect(request.getContextPath() + "/admin/category/categoryList.jsp");
		return;
	} else {
		System.out.println("추가 실패");
		out.println("<script>alert('카테고리 추가에 실패했습니다'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
		return;
	}
%>
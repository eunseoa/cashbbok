<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null) {
		out.println("<script>alert('모든 항목을 입력해주세요'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
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
		out.println("<script>alert('카테고리가 추가되었습니다'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
		return;
	} else {
		System.out.println("추가 실패");
		out.println("<script>alert('카테고리 추가에 실패했습니다'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
		return;
	}
%>
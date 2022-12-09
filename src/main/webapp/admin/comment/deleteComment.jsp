<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteComment(commentNo);
	
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/admin//help/helpOneListByAdmin.jsp?helpNo=" + helpNo);
		return;
	} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/admin/help/helpOneListByAdmin.jsp?helpNo=" + helpNo);
		return;
	}
%>
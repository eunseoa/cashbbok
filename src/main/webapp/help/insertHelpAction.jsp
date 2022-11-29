<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String helpMemo = request.getParameter("helpMemo");
	
	// Model 호출
	Help help = new Help();
	help.setMemberId(memberId);
	help.setHelpMemo(helpMemo);
	
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	
	if(row == 1) {
		System.out.println("등록성공");
		response.sendRedirect(request.getContextPath()+"/help/helpMain.jsp");
		return;
	} else {
		System.out.println("등록실패");
		response.sendRedirect(request.getContextPath()+"/help/helpMain.jsp");
		return;
	}
%>
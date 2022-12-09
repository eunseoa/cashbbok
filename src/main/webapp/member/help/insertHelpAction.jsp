<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String helpTitle = request.getParameter("helpTitle");
	String helpMemo = request.getParameter("helpMemo");
	
	// Model 호출
	Help help = new Help();
	help.setMemberId(memberId);
	help.setHelpTitle(helpTitle);
	help.setHelpMemo(helpMemo);
	
	HelpDao helpDao = new HelpDao();
	int row = helpDao.insertHelp(help);
	
	if(row == 1) {
		System.out.println("등록성공");
		out.println("<script>alert('문의가 등록됐습니다'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	} else {
		System.out.println("등록실패");
		out.println("<script>alert('문의등록에 실패했습니다'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	}
%>
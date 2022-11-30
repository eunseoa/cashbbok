<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)(session.getAttribute("loginMember"));
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpTitle = request.getParameter("helpTitle");
	String helpMemo = request.getParameter("helpMemo");
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	Help help = new Help();
	help.setHelpNo(helpNo);
	help.setHelpTitle(helpTitle);
	help.setHelpMemo(helpMemo);
	help.setMemberId(loginMember.getMemberId());
	
	HelpDao helpDao = new HelpDao();
	int row = helpDao.updateHelp(help);
	
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/help/helpOne.jsp?helpNo=" + helpNo);
		return;
	} else {
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/help/helpOne.jsp?helpNo=" + helpNo);
		return;
	}
%>
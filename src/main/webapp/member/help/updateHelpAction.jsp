<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	// 내용 미입력시
	if(request.getParameter("helpTitle") == null || request.getParameter("helpTitle").equals("")
		|| request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("입력되지않은 항목이 있습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/member/insertLoginForm.jsp?msg=" + msg);
		return;
	}
	
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
		response.sendRedirect(request.getContextPath()+"/member/help/helpOne.jsp?helpNo=" + helpNo);
		return;
	} else {
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/member/help/helpOne.jsp?helpNo=" + helpNo);
		return;
	}
%>
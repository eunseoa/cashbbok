<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 내용 미입력시
	if(request.getParameter("helpTitle") == null || request.getParameter("helpTitle").equals("")
		|| request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")) {
		String msg = URLEncoder.encode("입력되지않은 항목이 있습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/member/insertLoginForm.jsp?msg=" + msg);
		return;
	}

	String memberId = request.getParameter("memberId");
	String helpTitle = request.getParameter("helpTitle");
	String helpMemo = request.getParameter("ㅍ");
	
	// Model 호출
	Help help = new Help();
	help.setMemberId(memberId);
	help.setHelpTitle(helpTitle);
	help.setHelpMemo(helpMemo);
	
	HelpDao helpDao = new HelpDao();
	
	// 문의 등록 메소드
	int row = helpDao.insertHelp(help);
	
	if(row == 1) {
		System.out.println("문의 등록 성공");
		response.sendRedirect(request.getContextPath()+"/member/help/helpMain.jsp");
		return;
	} else {
		System.out.println("문의 등록 실패");
		out.println("<script>alert('문의등록에 실패했습니다'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	}
%>
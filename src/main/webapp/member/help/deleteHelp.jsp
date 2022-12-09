<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인시 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() > 0){ // 관리자가 문의 임의 삭제 방지
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/loginForm.jsp" + "';</script>");
		return;
	}
	
	if (request.getParameter("helpNo") == null || loginMember.getMemberId() == null) {
		out.println("<script>alert('오류'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(memberId, helpNo);
	
	if(row == 1) {
		System.out.println("삭제성공");
		out.println("<script>alert('문의를 삭제했습니다'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	} else {
		System.out.println("삭제실패");
		out.println("<script>alert('문의삭제에 실패했습니다'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	//로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	//접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} else if(loginMember.getMemberLevel() == 1) { // 관리자가 임의로 삭제 방지
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 삭제할 문의 값을 받지 못했을때
	if (request.getParameter("helpNo") == null || loginMember.getMemberId() == null) {
		response.sendRedirect(request.getContextPath()+"/member/help/helpMain.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(memberId, helpNo);
	
	if(row == 1) {
		System.out.println("문의 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/member/help/helpMain.jsp");
		return;
	} else {
		System.out.println("문의 삭제 실패");
		out.println("<script>alert('문의삭제에 실패했습니다'); location.href='" + request.getContextPath() + "/member/help/helpMain.jsp" + "';</script>");
		return;
	}
%>
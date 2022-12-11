<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 삭제할 멤버의 값을 받지 못했을때
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	
	// 멤버 삭제 메소드
	int row = memberDao.deleteMember(member);
	System.out.println(row + "<- deleteMember row");
	
	if(row == 1) {
		System.out.println("탈퇴성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		System.out.println("탈퇴실패");
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/member/memberOne.jsp" + "';</script>");
		return;
	}
	
%>
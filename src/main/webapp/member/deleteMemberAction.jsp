<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	if (session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
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
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMember(member);
	System.out.println(row + "<- deleteMember row");
	
	if(row == 1) {
		System.out.println("탈퇴성공");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		System.out.println("탈퇴실패");
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
	}
	
%>
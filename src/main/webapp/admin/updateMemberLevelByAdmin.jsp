<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int changeLevel = Integer.parseInt(request.getParameter("changeLevel"));
	System.out.println(memberNo);
	System.out.println(changeLevel);
	
	// Model 호출
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberLevel(changeLevel);
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(member);
	
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
%>
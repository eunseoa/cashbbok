<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	String memberPw = request.getParameter("memberPw");
	
	// Model 호출
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberName(memberName);
	paramMember.setMemberPw(memberPw);
	
	MemberDao memberDao = new MemberDao();
	Member updateMember = memberDao.updateMember(paramMember);
	session.setAttribute("loginMember", updateMember);
	
	response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
%>
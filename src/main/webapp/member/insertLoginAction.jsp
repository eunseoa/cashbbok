<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")
		|| request.getParameter("memberName") == null || request.getParameter("memberName").equals("")) {
		response.sendRedirect(request.getContextPath()+"/insertLoginForm.jsp");
		return;
	}

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId)) {
		System.out.println("중복아이디");
		response.sendRedirect(request.getContextPath()+"/insetMemberForm.jsp");
		return;
	}
	
	int row = memberDao.insertMember(member);
	System.out.println(row + "insertMemberAction row");
	
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
%>
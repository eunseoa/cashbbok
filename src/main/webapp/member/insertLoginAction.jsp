<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")
		|| request.getParameter("memberName") == null || request.getParameter("memberName").equals("")) {
		out.println("<script>alert('내용을 입력해주세요'); location.href='" + request.getContextPath()+"/member/insertLoginForm.jsp" + "';</script>");
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
	// 아이디가 중복이면
	if(memberDao.selectMemberIdCk(memberId)) {
		System.out.println("중복아이디");
		out.println("<script>alert('아이디가 중복됩니다'); location.href='" + request.getContextPath()+"/member/insertLoginForm.jsp" + "';</script>");
		return;
	}
	
	int row = memberDao.insertMember(member);
	if (row == 1) {
		System.out.println(row + "insertMemberAction row");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	} else {
		out.println("<script>alert('회원가입에 실패했습니다'); location.href='" + request.getContextPath()+"/member/insertLoginForm.jsp" + "';</script>");
	}
%>
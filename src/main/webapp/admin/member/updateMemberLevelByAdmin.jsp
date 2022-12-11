<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 수정할 멤버의 정보가 넘어오지않았을때
	if(request.getParameter("memberNo") == null || request.getParameter("memberNo") == null
		|| request.getParameter("changeLevel").equals("") || request.getParameter("changeLevel").equals("")) {
		out.println("<script>alert('오류'); location.href='" + request.getContextPath() + "/admin/category/categoryList.jsp" + "';</script>");
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
		System.out.println("회원 레벨 수정 성공");
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
		return;
	} else {
		System.out.println("회원 레벨 수정 실패");
		out.println("<script>alert('회원레벨 수정에 실패했습니다'); location.href='" + request.getContextPath() + "/admin/member/memberList.jsp" + "';</script>");
		return;
	}
%>
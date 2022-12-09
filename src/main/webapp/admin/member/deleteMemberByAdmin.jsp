<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 로그인 멤버 저장
	Member loginMember = (Member)session.getAttribute("loginMember");

	// 일반회원이거나 비로그인시 접근금지
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}

	// 삭제할 회원의 no 받아오기
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
			
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	// 삭제 메소드
	MemberDao memberDao = new MemberDao();
	int deleteRow = memberDao.deleteMemberByAdmin(member);
	System.out.println(deleteRow + " <- deleteRow row");
	
	// 삭제성공
	if(deleteRow == 1) {
		response.sendRedirect(request.getContextPath()+"/admin/member/memberList.jsp");
	}
%>
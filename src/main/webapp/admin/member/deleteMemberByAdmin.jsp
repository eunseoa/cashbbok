<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

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
		System.out.println("회원 탈퇴 성공");
		response.sendRedirect(request.getContextPath() + "/admin/member/memberList.jsp");
		return;
	} else {
		System.out.println("회원 탈퇴 실패");
		out.println("<script>alert('회원 강제탈퇴를 실패했습니다'); location.href='" + request.getContextPath() + "/admin/member/memberList.jsp" + "';</script>");
		return;
	}
%>
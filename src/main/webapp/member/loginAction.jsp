<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	// controller
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	System.out.println(paramMember.getMemberId());
	
	// 분리된 model을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	
	String redirectUrl = "/member/loginForm.jsp";
	
	if (resultMember != null) {
		session.setAttribute("loginMember", resultMember); // session안에 로그인아이디, 이름 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
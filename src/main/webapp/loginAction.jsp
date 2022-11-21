<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	// controller
	request.setCharacterEncoding("utf-8");
	String loginMemberId = request.getParameter("loginMemberId");
	String memberPw = request.getParameter("memberPw");
	
	Member paramMember = new Member(); // 모델 호출시 매개값
	
	
	// 분리된 model을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	String redirectUrl = "/loginForm.jsp";
	
	if (resultMember != null) {
		session.setAttribute("loginMember", resultMember); // session안에 로그인아이디, 이름 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
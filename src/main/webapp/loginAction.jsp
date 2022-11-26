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
	
	// 로그인한 사용자의 level
	int memberLevel = resultMember.getMemberLevel();
	System.out.println(memberLevel);
	
	String redirectUrl = "/loginForm.jsp";
	
	if (resultMember != null) {
		session.setAttribute("loginMember", resultMember); // session안에 로그인아이디, 이름 저장
		if(memberLevel == 1) {
			redirectUrl = "/admin/adminMain.jsp"; // 1이면 관리자페이지로
		} else {
			redirectUrl = "/cash/cashList.jsp"; // 0이면 가계부list로
		}
	}
	
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
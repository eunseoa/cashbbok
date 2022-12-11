<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	// controller
	request.setCharacterEncoding("utf-8");

	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	// 미입력시
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
			System.out.println("정보 미입력");
			String msg = URLEncoder.encode("입력되지않은 항목이 있습니다", "utf-8");
			response.sendRedirect(request.getContextPath() + "/log/loginForm.jsp?msg=" + msg);
			return;
		}
	
	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	System.out.println(paramMember.getMemberId());
	
	// 분리된 model을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	if (resultMember != null) {
		System.out.println("로그인 성공");
		session.setAttribute("loginMember", resultMember); // session안에 로그인아이디, 이름 저장
		int memberLevel = resultMember.getMemberLevel();
		System.out.println(memberLevel);
		if(memberLevel == 1) {
			response.sendRedirect(request.getContextPath() + "/admin/adminMain.jsp");
			return;// 관리자페이지로 이동
		} else {
			response.sendRedirect(request.getContextPath() + "/member/memberMain.jsp");
			return;// 일반회원페이지로 이동
		}
	} else {
		String msg = URLEncoder.encode("아이디나 비밀번호가 올바르지않습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp?msg=" + msg);
		return;
	}

%>
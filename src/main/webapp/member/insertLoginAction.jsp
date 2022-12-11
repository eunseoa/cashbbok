<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 내용 미입력시
	if(request.getParameter("memberId") == null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")
		|| request.getParameter("memberName") == null || request.getParameter("memberName").equals("")) {
		String msg = URLEncoder.encode("입력되지않은 항목이 있습니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/member/insertLoginForm.jsp?msg=" + msg);
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
		String msg = URLEncoder.encode("사용할 수 없는 아이디입니다", "utf-8");
		response.sendRedirect(request.getContextPath() + "/member/insertLoginForm.jsp?msg=" + msg);
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
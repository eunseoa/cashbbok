<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인시 접근금지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// cashNo 안넘어오면
	if(request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp");
		return;
	}
	
	// 값 받아오기
	String memberId = loginMember.getMemberId();
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	System.out.println(cashNo);
	
	// Model 호출
	Cash cash = new Cash();
	cash.setMemberId(memberId);
	cash.setCashNo(cashNo);
	
	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCash(cash);
	
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
		return;
	} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
		return;
	}
%>
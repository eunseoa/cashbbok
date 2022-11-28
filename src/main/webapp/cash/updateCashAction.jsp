<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	Long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	Cash cash = new Cash();
	cash.setCategoryNo(categoryNo);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(cashMemo);
	cash.setCashNo(cashNo);
	cash.setMemberId(memberId);
	
	CashDao cashDao = new CashDao();
	int row = cashDao.updateCash(cash);
	
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
		return;
	} else {
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date);
		return;
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	if (request.getParameter("year") == null || request.getParameter("year").equals("")
		|| request.getParameter("month") == null || request.getParameter("month").equals("")
		|| request.getParameter("date") == null || request.getParameter("date").equals("")
		|| request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")
		|| request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")
		|| request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")) {
		out.println("<script>alert('오류'); location.href='" + request.getContextPath() + "/cash/cashList.jsp" + "';</script>");
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
		System.out.println("가계부 내역 수정 성공");
		out.println("<script>alert('내역을 수정했습니다'); location.href='" + request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "';</script>");
		return;
	} else {
		System.out.println("가계부 내역 수정 실패");
		out.println("<script>alert('내역수정을 실패했습니다'); location.href='" + request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "';</script>");
		return;
	}
%>
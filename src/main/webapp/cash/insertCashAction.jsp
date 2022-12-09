<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.*"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%	
	// Controller
	request.setCharacterEncoding("utf-8");

	// 로그인되어있지않을때
	if(session.getAttribute("loginMember") == null) {
		out.println("<script>alert('로그인이 필요합니다.'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 
	if(request.getParameter("year") == null || request.getParameter("year").equals("")
			|| request.getParameter("month") == null || request.getParameter("month").equals("")
			|| request.getParameter("date") == null || request.getParameter("date").equals("")) {
			out.println("<script>alert('비정상적인 접근입니다'); location.href='" + request.getContextPath() + "/cash/cashList.jsp" + "';</script>");
			return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	if(request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("")
		|| request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")
		|| request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")) {
			out.println("<script>alert('모든 항목을 입력해주세요'); location.href='" + request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "';</script>");
		return;
	}

	String memberId = request.getParameter("memberId");
	String cashDate = request.getParameter("cashDate");
	String cashMemo = request.getParameter("cashMemo");
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	Cash cash = new Cash();
	cash.setMemberId(memberId);
	cash.setCashDate(cashDate);
	cash.setCashMemo(cashMemo);
	cash.setCashPrice(cashPrice);
	cash.setCategoryNo(categoryNo);
	
	CashDao cashDao =new CashDao();
	int insertCash = cashDao.insertCash(cash);
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year=" + year + "&month=" + month +"&date=" + date);
%>
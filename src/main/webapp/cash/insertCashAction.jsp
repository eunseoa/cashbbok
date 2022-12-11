<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%	
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비정상적인 접근일때
	if(request.getParameter("year") == null || request.getParameter("year").equals("")
			|| request.getParameter("month") == null || request.getParameter("month").equals("")
			|| request.getParameter("date") == null || request.getParameter("date").equals("")) {
			out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/cash/cashList.jsp" + "';</script>");
			return;
	}
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// 추가할 내용 미입력시
	if(request.getParameter("cashDate") == null || request.getParameter("cashDate").equals("")
		|| request.getParameter("cashPrice") == null || request.getParameter("cashPrice").equals("")
		|| request.getParameter("cashMemo") == null || request.getParameter("cashMemo").equals("")) {
			String msg = URLEncoder.encode("입력되지않은 항목이 있습니다", "utf-8");
			response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
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
	
	// Model 호출
	CashDao cashDao =new CashDao();
	
	// 가계부 내역 추가 메소드
	int insertCash = cashDao.insertCash(cash);
	
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year=" + year + "&month=" + month +"&date=" + date);
%>
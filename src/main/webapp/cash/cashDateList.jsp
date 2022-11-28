<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("year") == null || request.getParameter("year").equals("")
		|| request.getParameter("month") == null || request.getParameter("month").equals("")
		|| request.getParameter("date") == null || request.getParameter("date").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// Model 호출
	// 카테고리 목록 출력
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash 목록 출력
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
	</head>
	<body>
		<div>
			<a href="<%=request.getContextPath() %>/cash/cashList.jsp?year=<%=year %>&month=<%=month-1 %>&date=<%=date %>">되돌아가기</a>
			<%=year %>년 <%=month %>월 <%=date %>일
		</div>
		<!--  -->
		<form action="<%=request.getContextPath() %>/cash/insertCashAction.jsp" method="post">
			<input type="hidden" name="year" value="<%=year %>">
			<input type="hidden" name="month" value="<%=month %>">
			<input type="hidden" name="date" value="<%=date %>">
			<table>
				<tr>
					<td>cashDate</td>
					<td>
						<input type="text" name="cashDate" value="<%=year %>-<%=month %>-<%=date %>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td>
						<select name="categoryNo">
							<%
								for(Category c : categoryList) {
							%>
									<option value="<%=c.getCategoryNo() %>">
										<%=c.getCategoryKind() %> <%=c.getCategoryName() %>
									</option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>cashPrice</td>
					<td>
						<input type="text" name="cashPrice">
					</td>
				</tr>
				<tr>
					<td>cashMemo</td>
					<td>
						<textarea rows="3" cols="50" name="cashMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type="submit">입력</button>
		</form>
		<table>
			<tr>
				<th>categoryKind</th>
				<th>categoryName</th>
				<th>cashPrice</th>
				<th>memo</th>
				<th>수정</th> <!-- /cash/updateCashForm.jsp?cashNo= -->
				<th>삭제</th> <!-- /cash/deleteCash.jsp?cashNo= -->
			</tr>
			<tr>
				<%
					for(HashMap<String, Object> m : list) {
						
						String cashDate = (String)m.get("cashDate");
						System.out.println(cashDate);
						if(Integer.parseInt(cashDate.substring(8)) == date) {
							int cashNo = (Integer)(m.get("cashNo"));
							System.out.println(cashNo);
							int categoryNo = (Integer)(m.get("categoryNo"));
							System.out.println(categoryNo);
				
				%>
							<td>[<%=(String)(m.get("categoryKind")) %>]</td>
							<td><%=(String)(m.get("categoryName")) %></td>
							<td><%=(Long)(m.get("cashPrice")) %>원</td>
							<td><%=(String)(m.get("cashMemo")) %></td>
							<td>
								<a href="<%=request.getContextPath() %>/cash/updateCashForm.jsp?cashNo=<%=cashNo %>&categoryNo=<%=categoryNo %>&year=<%=year %>&month=<%=month %>&date=<%=date %>">수정</a>
							</td>
							<td>
								<a href="<%=request.getContextPath() %>/cash/deleteCashAction.jsp?cashNo=<%=cashNo %>&categoryNo=<%=categoryNo %>&year=<%=year %>&month=<%=month %>&date=<%=date %>">삭제</a>
							</td>
							</tr><tr>
				<%
						}
					}
				%>
		</table>
	</body>
</html>
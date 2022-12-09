<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인시 접근금지
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	// Model 호출
	// 카테고리 출력
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash 목록 출력
	Cash cash = new Cash();
	cash.setMemberId(memberId);
	cash.setCashNo(cashNo);
	
	CashDao cashDao = new CashDao();
	Cash updateList = cashDao.selectUpdateCashOne(cash);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/cash/updateCashAction.jsp?cashNo=<%=updateList.getCashNo() %>&year=<%=year %>&month=<%=month %>&date=<%=date %>" method="post">
				<table>
					<tr>
						<td>날짜</td>
						<td><input type="text" name="cashDate" value="<%=year %>-<%=month %>-<%=date %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>수입/지출</td>
						<td>
							<select name="categoryNo">
								<%
									for(Category c : categoryList) {
								%>
										<option value="<%=c.getCategoryNo()%>"
								<%
											if(c.getCategoryNo() == categoryNo) {
								%>
												selected
								<%
											} else {
												
											}
								%>>
											<%=c.getCategoryKind() %> <%=c.getCategoryName() %>
										</option>
								<%
									}
								%>
							</select>
						</td>
					</tr>
					<tr>
						<td>금액</td>
						<td><input type="text" name="cashPrice" value="<%=updateList.getCashPrice() %>"></td>
					</tr>
					<tr>
						<td>memo</td>
						<td><input type="text" name="cashMemo" value="<%=updateList.getCashMemo() %>"></td>
					</tr>
				</table>
				<button type="submit">수정</button>
			</form>
		</div>
	</body>
</html>
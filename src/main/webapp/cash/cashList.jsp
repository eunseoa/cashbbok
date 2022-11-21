<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%
	// Controller : session, rquest
	request.setCharacterEncoding("utf-8");
	int year = 0;
	int month = 0;
	
	
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR); // 오늘날짜의 년도
		month = today.get(Calendar.MONTH); // 오늘날짜의 달
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		if (month == -1) { // 1월달에서 이전달을 누르면
			month = 11; 
			year--; 
		}
		if (month == 12) { // 12월달에서 다음달을 누르면
			month = 0;
			year++; 
		}
	}

	// 출력하고자 하는 년,월과 1일의 요일 (일 1, 월2, ..)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 1일의 요일 정보
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 해당 달의 마지막날짜
	
	// 달력의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // 나누어 떨어지면 0
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7); // 7 - 나머지
	}
	
	int totalTd = beginBlank + lastDate + endBlank; // 전체 td의 개수
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(year, month+1);
	
	// Vew : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashList</title>
	</head>
	<body>
		<div>
			<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
		</div>
		<div>
			<%=year %>년 <%=month+1 %>월
		</div>
		<div>
			<table>
				<tr>
					<th>일요일</th>
					<th>월요일</th>
					<th>화요일</th>
					<th>수요일</th>
					<th>목요일</th>
					<th>금요일</th>
					<th>토요일</th>
				</tr>
				<tr>
					<!-- 달력 -->
					<%
						for (int i=1; i<=totalTd; i++) {
					%>
							<td>
					<%
								int date = i - beginBlank;
								if (date > 0 && date <= lastDate) {
					%>		
									<%=date %>
							</td>
					<%
								}
					
							if(i % 7 == 0 && i != totalTd) {
					%>
								</tr><tr> 
					<%
							}
						}
					%>
			</table>
		</div>
		<div>
			<table>
				<tr>
					<th>cashNo</th>
					<th>cashDate</th>
					<th>cashPrize</th>
					<th>categoryNo</th>
					<th>categoryKind</th>
					<th>categoryName</th>
				</tr>
			<%
				for(HashMap<String, Object> m : list) {
			%>		<tr>
						<td><%=(Integer)(m.get("cashNo")) %></td>
						<td><%=m.get("cashDate") %></td>
						<td><%=m.get("cashPrize") %></td>
						<td><%=(Integer)(m.get("categoryNo")) %></td>
						<td><%=m.get("categoryKind") %></td>
						<td><%=m.get("categoryName") %></td>
					</tr>
			<%
				}
			%>
			</table>
		</div>
	</body>
</html>
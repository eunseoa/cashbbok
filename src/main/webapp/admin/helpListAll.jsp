<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비로그인, 일반회원 접근 금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
 %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<table border="1">
				<tr>
					<th>no</th>
					<th>제목</th>
					<th>회원</th>
					<th>날짜</th>
					<th>답변현황</th>
				</tr>
				<tr>
				<%
					for(HashMap<String, Object> m : list) {
				%>
						<td><%=m.get("helpNo") %></td>
						<td><a href="<%=request.getContextPath() %>/help/helpOneListByAdmin.jsp?helpNo=<%=m.get("helpNo") %>"><%=m.get("helpTitle") %></a></td>
						<td><%=m.get("memberId") %></td>
						<td><%=m.get("helpCreatedate") %></td>
						<%
							if(m.get("commentCreatedate") == null) {
						%>
								<td>답변대기</td>
						<%
							} else {
						%>
								<td>답변완료</td>
						<%
							}
						%>
						</tr><tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>
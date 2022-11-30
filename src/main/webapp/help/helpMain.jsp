<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 로그인 아이디
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(memberId);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>고객센터</title>
	</head>
	<body>
		<div>
			<h1>고객센터</h1>
			<div>
				<a href="<%=request.getContextPath() %>/help/insertHelpForm.jsp">문의하기</a>
			</div>
			<div>
				<table>
					<tr>
						<th>no</th>
						<th>문의글</th>
						<th>아이디</th>
						<th>작성일자</th>
						<th>답변현황</th>
					</tr>
					<tr>
					<%
						for (HashMap<String, Object> m : helpList) {
					%>
							<td><%=m.get("helpNo") %></td>
							<td><a href="<%=request.getContextPath() %>/help/helpOne.jsp?helpNo=<%=m.get("helpNo") %>"><%=m.get("helpTitle") %></a></td>
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
		</div>
	</body>
</html>
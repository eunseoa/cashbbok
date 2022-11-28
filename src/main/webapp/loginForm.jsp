<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// Cotroller
	request.setCharacterEncoding("utf-8");

	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// Model 호출
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// 마지막페이지
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	if(lastPage % rowPerPage != 0) {
		lastPage++;
	}
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
	</head>
	<body>
		<div>
			<div>
				<table>
					<tr>
						<th>공지내용</th>
						<td>날짜</td>
					</tr>
					<%
						for(Notice n : list) {
					%>
							<tr>
								<td><%=n.getNoticeMemo() %></td>
								<td><%=n.getCreatedate() %></td>
							</tr>
					<%
						}
					%>
					<tr>
						<td colspan="2">
						<%
							if(currentPage !=  0) {
						%>
								<a href="<%=request.getContextPath() %>/loginForm.jsp?currentPage=1">처음</a>
						<%
							}

							if(currentPage > 1) {
						%>
								<a href="<%=request.getContextPath() %>/loginForm.jsp?currentPage=<%=currentPage - 1 %>">이전</a>
						<%
							}
						
							if(currentPage < lastPage) {
						%>
								<a href="<%=request.getContextPath() %>/loginForm.jsp?currentPage=<%=currentPage + 1 %>">다음</a>
						<%
							}
							
							if(lastPage != 0) {
						%>
								<a href="<%=request.getContextPath() %>/loginForm.jsp?currentPage=<%=lastPage %>">마지막</a>
						<%
							}
						%>
						</td>
					</tr>
				</table>
			</div>
			<form action="<%=request.getContextPath() %>/loginAction.jsp" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="memberId">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="memberPw">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit">로그인</button>
						</td>
					</tr>
				</table>
				<a href="<%=request.getContextPath() %>/member/insertLoginForm.jsp">회원가입</a>
			</form>
		</div>
	</body>
</html>
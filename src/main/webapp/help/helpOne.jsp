<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<table>
				<tr>
					<td>제목</td>
					<td><%=help.getHelpTitle() %></td>
				</tr>
				<tr>
					<td>회원</td>
					<td><%=help.getMemberId() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><%=help.getHelpMemo() %></td>
				</tr>
				<tr>
					<td>수정일자</td>
					<td><%=help.getUpdatedate() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td><%=help.getCreatedate()%></td>
				</tr>
			</table>
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model 호출
	Help help = new Help();
	help.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);
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
					<td><%=helpOne.getHelpTitle() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><%=helpOne.getHelpMemo() %></td>
				</tr>
				<tr>
					<td>회원</td>
					<td><%=helpOne.getMemberId() %></td>
				</tr>
				<tr>
					<td>수정일자</td>
					<td><%=helpOne.getUpdatedate() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td><%=helpOne.getCreatedate() %></td>
				</tr>
			</table>
		</div>
		<div>
			<jsp:include page="/comment/commentList.jsp"></jsp:include>
   		</div>
	</body>
</html>
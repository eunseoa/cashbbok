<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() > 0) { // 관리자가 고객문의 임의로 수정 방지
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	Help help = new Help();
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectUpdateHelp(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<form action="<%=request.getContextPath() %>/help/updateHelpAction.jsp" method="post">
				<table>
					<tr>
						<td><input type="hidden" name="helpNo" value="<%=helpOne.getHelpNo() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="helpTitle" value="<%=helpOne.getHelpTitle() %>"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="helpMemo"><%=helpOne.getHelpMemo() %></textarea></td>
					</tr>
					<tr>
						<td>등록일자</td>
						<td><input type="text" name="createdate" value="<%=helpOne.getCreatedate() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<td>회원</td>
						<td><input type="text" name="memberId" value="<%=helpOne.getMemberId() %>" readonly="readonly"></td>
					</tr>
				</table>
				<button type="submit">수정</button>
			</form>
		</div>
	</body>
</html>
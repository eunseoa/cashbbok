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
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> commentList = commentDao.selectCommentList(helpNo);
	
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
				<%
					for(HashMap<String, Object> c : commentList) {
				%>
						<td><%=c.get("commentMemo") %></td>
						<td><%=c.get("memberId") %></td>
						<td><%=c.get("createdate") %></td>
						<%
							if(loginMember.getMemberLevel() == 1) {
						%>
								<!-- 수정 삭제 비동기식으로 바꿀예정 -->
								<td><a href="<%=request.getContextPath() %>/comment/updateCommentForm.jsp?helpNo=<%=helpNo %>&commentNo=<%=c.get("commentNo") %>">수정</a></td>
								<td><a href="<%=request.getContextPath() %>/comment/deleteComment.jsp?helpNo=<%=helpNo %>&commentNo=<%=c.get("commentNo") %>">삭제</a></td>
						<%
							}
						%>
				<%
					}
				%>
				</tr>
			</table>
		</div>
	</body>
</html>
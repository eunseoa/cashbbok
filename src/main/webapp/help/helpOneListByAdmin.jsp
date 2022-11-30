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
	
	if(request.getParameter("helpNo") == null) {
		System.out.println(request.getParameter("helpNo"));
	} else {
		System.out.println(request.getParameter("helpNo"));
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model 호출
	Help help = new Help();
	help.setHelpNo(helpNo);
	
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);
	
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
			<table>
				<%
					for(HashMap<String, Object> c : commentList) {
						System.out.println((c.get("commentMemo")));
				%>
						<tr>
				<%
						if(c.get("commentMemo") == null) {
				%>
							<td><span>답변 대기</span></td>
				<%
						} else {
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
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>
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
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	// 문의 내용
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelpOne(helpNo);
	
	// 댓글있으면 수정/삭제 출력안함
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(memberId);
	
	// 댓글 출력
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
				<%
					for(HashMap<String, Object> m : helpList) {
						if(m.get("commentCreatedate") == null && (Integer)m.get("helpNo") == helpNo) {
				%>
							<tr>
								<td><a href="<%=request.getContextPath() %>/help/updateHelpForm.jsp?helpNo=<%=helpNo %>">수정</a></td>
								<td><a href="<%=request.getContextPath() %>/help/deleteHelp.jsp?helpNo=<%=helpNo %>">삭제</a></td>
							</tr>
				<%
						}

					}
				%>
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
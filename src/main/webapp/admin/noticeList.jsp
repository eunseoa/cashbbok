<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출 : noticeList
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// 마지막페이지
	int noticeCnt = noticeDao.selectNoticeCount();
	int lastPage = noticeCnt / rowPerPage;
	if(lastPage % rowPerPage != 0) {
		lastPage++;
	}
	
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/adminMain.jsp"></jsp:include>
   		</div>
		<div>
			<!-- noticeList contents -->
			<h1>공지</h1>
			<table>
				<tr>
					<th>공지내용</th>
					<th>공지날짜</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<tr>
				<%
					for(Notice n : list) {
				%>
						<td><%=n.getNoticeMemo() %></td>
						<td><%=n.getCreatedate() %></td>
						<td><a href="<%=request.getContextPath() %>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo() %>"></a></td>
						<td>삭제</td>
						</tr>
				<%
					}
				%>
				<tr>
					<td colspan="4">
						<%
							if(currentPage != 0) {
						%>
								<a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=1">처음</a>
						<%
							}
							
							if (currentPage > 1) {
						%>
								<a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=<%=currentPage - 1 %>">이전</a>
						<%
							}
							
							if (currentPage < lastPage) {
						%>
								<a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=<%=currentPage + 1 %>">다음</a>
						<%
							}
							
							if (lastPage != 0) {
						%>
								<a href="<%=request.getContextPath() %>/admin/noticeList.jsp?currentPage=<%=lastPage %>">마지막</a>
						<%
							}
						%>
					
					</td>
				</tr>
			</table>
		</div>
		<form action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp" method="post">
			<div>
				<table>
					<tr>
						<th>내용</th>
					</tr>
					<tr>
						<td>
							<textarea name="noticeMemo"></textarea>
						</td>
					</tr>
				</table>
				<button type="submit">등록</button>
			</div>
		</form>
	</body>
</html>
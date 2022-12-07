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
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByMember.jsp"></jsp:include>
		<main class="main-content position-relative border-radius-lg">
			<div class="container-fluid py-4">
				<div class="card" style="height: 900px;">
					<div class="card-header pb-0">
						<div class="pb-4">
							<h4>고객센터</h4>
							<a href="<%=request.getContextPath() %>/help/insertHelpForm.jsp">문의하기</a>
						</div>
						<div class="card-body px-0 pt-0 pb-0">
							<table class="table align-items-center mb-0">
								<tr>
									<th>no</th>
									<th>제목</th>
									<th>아이디</th>
									<th>작성일자</th>
									<th>답변현황</th>
								</tr>
								<tr>
								<%
									for(HashMap<String, Object> m : helpList) {
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
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
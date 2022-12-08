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
		<style>
			th {
				width: 300px;
			}
		</style>
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<%
			if (loginMember.getMemberLevel() == 1) {
		%>
				<jsp:include page="/inc/sidebarByAdmin.jsp"></jsp:include>
		<%
			} else {
		%>
				<jsp:include page="/inc/sidebarByMember.jsp"></jsp:include>
		<%
			}
 		%>
		<main class="main-content border-radius-lg">
			<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
				<div class="container-fluid py-1 px-3">
					<div class="ms-md-auto pe-md-3 d-flex align-items-center">
					</div>
					<ul class="navbar-nav  justify-content-end">
						<li class="nav-item d-flex align-items-center">
							<div class="nav-link text-white font-weight-bold px-0">
								<i class="fa fa-user me-sm-1"></i>
								<span class="d-sm-inline d-none"><%=loginMember.getMemberId() %>, welcome!</span>
							</div>
						</li>
					</ul>
				</div>
			</nav>
			<div class="container-fluid py-4">
				<div class="card" style="height: 900px;">
					<div class="card-header pb-0">
						<div class="row">
							<div class="col-6 d-flex align-items-center">
								<h4 class="mb-0">내가 작성한 문의글</h4>
							</div>
							<div class="col-6 text-end">
								<a href="<%=request.getContextPath() %>/help/insertHelpForm.jsp" class="btn bg-gradient-primary btn-lg">문의하기</a>
							</div>
						</div>
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<table class="table align-items-center mb-0">
								<tr>
									<th style="width: 100px;">no</th>
									<th>제목</th>
									<th>아이디</th>
									<th>작성일자</th>
									<th>답변현황</th>
								</tr>
								<tr>
								<%
									for(HashMap<String, Object> m : helpList) {
										String helpCreatedate = (String)(m.get("helpCreatedate"));
								%>
										<td><%=m.get("helpNo") %></td>
										<td><a href="<%=request.getContextPath() %>/help/helpOne.jsp?helpNo=<%=m.get("helpNo") %>"><%=m.get("helpTitle") %></a></td>
										<td><%=m.get("memberId") %></td>
										<td><%=helpCreatedate.substring(0, 10) %></td>
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
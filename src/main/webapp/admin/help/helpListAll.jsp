<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비로그인, 일반회원 접근 금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
 %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HelpList</title>
		<link rel="shortcut icon" type="image/x-icon" href="../../assets/img/favicon.ico">
		<link href="../../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByAdmin.jsp"></jsp:include>
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
								<h4 class="mb-0">고객 문의사항</h4>
							</div>
							<div class="col-6 text-end">
								
							</div>
						</div>
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<table class="table align-items-center mb-0">
								<tr>
									<th>no</th>
									<th>제목</th>
									<th>회원</th>
									<th>날짜</th>
									<th>답변현황</th>
								</tr>
								<tr>
								<%
									for(HashMap<String, Object> m : list) {
								%>
										<td><%=m.get("helpNo") %></td>
										<td><a href="<%=request.getContextPath() %>/admin/help/helpOneListByAdmin.jsp?helpNo=<%=m.get("helpNo") %>"><%=m.get("helpTitle") %></a></td>
										<td>
											<%
												if (m.get("memberId") == null) {
											%>
													<span>탈퇴한 회원</span>
											<%
												} else {
											%>
													<span><%=m.get("memberId") %></span>
											<%
												}
											%>
										</td>
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
							</table>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
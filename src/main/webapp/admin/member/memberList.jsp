<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	} 
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberByPage(beginRow, rowPerPage);
	
	int memberCnt = memberDao.selectMembetCount();
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
								<h4 class="mb-0">회원 관리</h4>
							</div>
							<div class="col-6 text-end">
								
							</div>
						</div>
						<div class="card-body px-0 text-center">
							<table class="table align-items-center mb-0">
								<tr>
								<th>멤버번호</th>
								<th>아이디</th>
								<th style="width:150px;">레벨</th>
								<th></th>
								<th>이름</th>
								<th>마지막수정일자</th>
								<th>생성일자</th>
								<th>깅제탈퇴</th>
							</tr>
							<tr>
							<%
								for(Member m : list) {
							%>
									<td><%=m.getMemberNo() %></td>
									<td><%=m.getMemberId() %></td>
									<form action="<%=request.getContextPath() %>/admin/member/updateMemberLevelByAdmin.jsp?memberLevel=<%=m.getMemberLevel() %>&memberNo=<%=m.getMemberNo() %>" method="post">
										<td>
										<%
											if(m.getMemberLevel() == 1) {
										%>
												<select name="changeLevel" class="form-control" style="width:150px;">
													<option value="1" selected>관리자</option>
													<option value="0">일반회원</option>
												</select>
										<%
											} else {
										%>
												<select name="changeLevel" class="form-control" style="width:150px;">
													<option value="1">관리자</option>
													<option value="0" selected>일반회원</option>
												</select>
										<%
											}
										%>
										</td>
										<td><button type="submit" class="btn bg-gradient-primary btn-sm">수정</button></td>
									</form>
									<td><%=m.getMemberName() %></td>
									<td><%=m.getUpdatedate() %></td>
									<td><%=m.getCreatedate() %></td>
									<td>
										<a href="<%=request.getContextPath() %>/admin/member/deleteMemberByAdmin.jsp?memberNo=<%=m.getMemberNo() %>">강제탈퇴</a>
									</td>
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
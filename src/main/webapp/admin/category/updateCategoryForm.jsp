<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 로그인 정보 저장
	Member loginMember = (Member)session.getAttribute("loginMember");

	//접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 일반회원일 경우
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}

	if(request.getParameter("categoryNo") == null || request.getParameter("categoryNo").equals("")) {
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	System.out.println(categoryNo);
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	// 수정할 카테고리 내용 출력
	Category category = categoryDao.selectCategoryOne(categoryNo);
	
	// 현재있는 카테고리 리스트 출력
	ArrayList<Category> categoryList = categoryDao.selectCategoryListbyAdmin();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>UpdateCategory</title>
		<link rel="shortcut icon" type="image/x-icon" href="../../assets/img/favicon.ico">
		<link href="../../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			table {
				width: 600px;
				border-collapse: separate;
				border-spacing: 0 30px;
			}
		</style>
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByAdmin.jsp"></jsp:include>
		<main class="main-content position-relative border-radius-lg ">
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
	    <!-- End Navbar -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-5 mt-4" style="height: 330px;">
						<div class="card h-100 mb-4">
							<div class="card-header pb-0 px-3">
								<div class="row">
									<div class="col-md-6">
										<h6 class="mb-0">수정</h6>
									</div>
								</div>
							</div>
							<form action="<%=request.getContextPath() %>/admin/updateCategoryAction.jsp" method="post">
								<div class="card-body pt-4 p-3 text-center">
									<table>
										<tr>
											<th>categoryNo</th>
											<td><input type="text" class="form-control" name="categoryNo" value="<%=category.getCategoryKind() %>" readonly="readonly"></td>
										</tr>
										<tr>
											<th>categoryName</th>
											<td><input type="text" class="form-control" name="categoryName" value="<%=category.getCategoryName() %>"></td>
										</tr>
										<tr>
											<td colspan="2"><button type="submit" class="btn btn-primary btn-lg w-100">수정</button></td>
										</tr>
									</table>
								</div>
							</form>  
						</div>
					</div>
					<div class="col-md-7 mt-4">
						<div class="card">
							<div class="card-header pb-0 px-3">
								<div class="row">
									<div class="col-md-6">
										<h6 class="mb-0">CategoryList</h6>
									</div>
								</div>	
							</div>
							<div class="card-body pt-4 p-3">
								<ul class="list-group">
									<li class="list-group-item border-0 bg-gray-100 border-radius-lg">
										<table>
											<tr>
												<th>수입/지출</th>
												<th>이름</th>
											</tr>
										<%
											for(Category c : categoryList) {
										%>
											<tr>
												<td><%=c.getCategoryKind() %></td>
												<td><%=c.getCategoryName() %></td>
											
											</tr>
										<%
											}
										%>
										</table>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
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
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListbyAdmin();
	
	// 최근 공지 5개, 최근 멤버 5명 보여줌
	
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
								<h4 class="mb-0">Category List</h4>
							</div>
							<div class="col-6 text-end">
								<button type="button" class="btn bg-gradient-primary btn-lg" data-bs-toggle="modal" data-bs-target="#exampleModal" style="float:right;">추가</button>
								<form action="<%=request.getContextPath() %>/admin/category/insertCategoryAction.jsp">
								<!-- Modal -->
									<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalLabel">Category 추가</h5>
												</div>
												<div class="modal-body">
													<select name="categoryKind" class="form-control">
														<option value="수입">수입</option>
														<option value="지출">지출</option>
													</select>
													<br>
													<input type="text" name="categoryName" class="form-control" placeholder="">
												</div>
												<div class="modal-footer">
													<button type="submit" class="btn bg-gradient-primary" data-bs-dismiss="modal">취소</button>
													<button type="submit" class="btn bg-gradient-secondary">추가</button>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="card-body px-0 text-center">
							<table class="table align-items-center mb-0">
								<tr>
									<th style="width:100px;">no</th>
									<th>수입/지출</th>
									<th>이름</th>
									<th>마지막 수정 날짜</th>
									<th>생성 날짜</th>
									<th>수정</th>
									<th>삭제</th>
								</tr>
								<tr>
								<%
									for(Category c : categoryList) {
								%>
										<td><%=c.getCategoryNo() %></td>
										<td><%=c.getCategoryKind() %></td>
										<td><%=c.getCategoryName() %></td>
										<td><%=c.getUpdatedate() %></td>
										<td><%=c.getCreatedate() %></td>
										<td>
											<a class="btn btn-link text-dark px-3 mb-0" href="<%=request.getContextPath() %>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo() %>">
												<i class="fas fa-pencil-alt text-dark"></i>
											</a>
										</td>
										<td>
											<a class="btn btn-link text-danger text-gradient px-3 mb-0" href="<%=request.getContextPath() %>/admin/category/deleteCategory.jsp?categoryNo=<%=c.getCategoryNo() %>">
												<i class="far fa-trash-alt"></i>
											</a>
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
		<script src="https://demos.creative-tim.com/soft-ui-design-system-pro/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
	</body>
</html>
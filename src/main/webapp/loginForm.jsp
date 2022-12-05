<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Cotroller
	request.setCharacterEncoding("utf-8");
	
	if (session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// Model 호출
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// 마지막페이지
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	if (lastPage % rowPerPage != 0) {
		lastPage++;
	}

	// View
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
		<link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
		<title>
			Sign in
		</title>
		<!--     Fonts and icons     -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
		<!-- Nucleo Icons -->
		<link href="assets/css/nucleo-icons.css" rel="stylesheet" />
		<link href="assets/css/nucleo-svg.css" rel="stylesheet" />
		<!-- Font Awesome Icons -->
		<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
		<link href="assets/css/nucleo-svg.css" rel="stylesheet" />
		<!-- CSS Files -->
		<link id="pagestyle" href="assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
	</head>
	<body>
		<main class="main-content  mt-0">
			<section>
				<div class="page-header min-vh-100">
					<div class="container">
						<div class="row">
							<div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
								<div class="card card-plain">
									<div class="card-header pb-0 text-start">
										<h4 class="font-weight-bolder">Sign In</h4>
										<p class="mb-0">Enter your id and password to sign in</p>
									</div>
									<div class="card-body">
										<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
											<div class="mb-3">
												<input type="text" class="form-control form-control-lg" name="memberId" placeholder="id" aria-label="id">
											</div>
											<div class="mb-3">
												<input type="password" class="form-control form-control-lg" name="memberPw" placeholder="Password" aria-label="Password">
											</div>
											<div class="form-check form-switch">
												<input class="form-check-input" type="checkbox" id="rememberMe"> <label class="form-check-label" for="rememberMe">Remember me</label>
											</div>
											<div class="text-center">
												<button type="submit" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Sign in</button>
											</div>
										</form>
									</div>
									<div class="card-footer text-center pt-0 px-lg-2 px-1">
										<p class="mb-4 text-sm mx-auto">
											Don't have an account? <a href="<%=request.getContextPath()%>/member/insertLoginForm.jsp" class="text-primary text-gradient font-weight-bold">Sign up</a>
										</p>
									</div>
								</div>
							</div>
							<div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 end-0 text-center justify-content-center flex-column">
								<div class="position-relative h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center overflow-hidden">
									<span class="mask"></span>
									<table>
										<tr>
											<th>최근 공지 내용</th>
											<th>날짜</th>
										</tr>
										<%
											for (Notice n : list) {	
										%>
											<tr>
												<td><%=n.getNoticeMemo()%></td>
												<td><%=n.getCreatedate()%></td>
											</tr>
										<%
											}
										%>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</main>
		<!--   Core JS Files   -->
		<script src="assets/js/core/popper.min.js"></script>
		<script src="assets/js/core/bootstrap.min.js"></script>
		<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
		<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
		<script>
			var win = navigator.platform.indexOf('Win') > -1;
			if (win && document.querySelector('#sidenav-scrollbar')) {
				var options = {
					damping : '0.5'
				}
				Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
						options);
			}
		</script>
		<!-- Github buttons -->
		<script async defer src="https://buttons.github.io/buttons.js"></script>
		<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
		<script src="assets/js/argon-dashboard.min.js?v=2.0.4"></script>
	</body>
</html>
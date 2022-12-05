<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/favicon.ico">
		<link rel="icon" type="image/png" href="../assets/img/favicon.ico">
		<title>
		Sign up
		</title>
		<!--     Fonts and icons     -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
		<!-- Nucleo Icons -->
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
		<!-- Font Awesome Icons -->
		<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
		<link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
		<!-- CSS Files -->
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
	</head>
	<body class="">
		<!-- End Navbar -->
		<main class="main-content  mt-0">
			<div class="page-header align-items-start min-vh-30 t-5 pb-11 m-3 border-radius-lg">
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5 text-center mx-auto">
							<h1 class="text-black mb-2 mt-5">Welcome!</h1>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row mt-lg-n10 mt-md-n11 mt-n10 justify-content-center">
					<div class="col-xl-4 col-lg-5 col-md-7 mx-auto">
						<div class="card z-index-0">
							<div class="card-header text-center pt-4">
								<h5>Register with</h5>
							</div>
							<div class="card-body">
								<form action="<%=request.getContextPath() %>/member/insertLoginAction.jsp" method="post">
									<div class="mb-3">
										<input type="text" name="memberName" class="form-control" placeholder="Name" aria-label="Name">
									</div>
									<div class="mb-3">
										<input type="text" name="memberId" class="form-control" placeholder="Id" aria-label="Id">
									</div>
									<div class="mb-3">
										<input type="password" name="memberPw" class="form-control" placeholder="Password" aria-label="Password">
									</div>
									<div class="text-center">
										<button type="submit" class="btn bg-gradient-dark w-100 my-4 mb-2">회원가입</button>
									</div>
									<p class="text-sm mt-3 mb-0">
										Already have an account? <a href="<%=request.getContextPath() %>/loginForm.jsp" class="text-dark font-weight-bolder">로그인</a>
									</p>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		<!-- -------- START FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
		<footer class="footer py-5">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 mx-auto text-center mb-4 mt-2">
						<a href="https://blog.naver.com/0602dmstj" target="_blank" class="text-secondary me-xl-4 me-4"> <span class="text-lg fab fa-dribbble"></span></a>
						<a href="https://github.com/eunseoa" target="_blank" class="text-secondary me-xl-4 me-4"> <span class="text-lg fab fa-github"></span></a>
					</div>
				</div>
				<div class="row">
					<div class="col-8 mx-auto text-center mt-1">
						<p class="mb-0 text-secondary">
							Copyright ©
							<script>
								document.write(new Date().getFullYear())
							</script>
							Soft by Creative Tim.
						</p>
					</div>
				</div>
			</div>
		</footer>
		<!-- -------- END FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
		<!--   Core JS Files   -->
		<script src="../assets/js/core/popper.min.js"></script>
		<script src="../assets/js/core/bootstrap.min.js"></script>
		<script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
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
		<script src="../assets/js/argon-dashboard.min.js?v=2.0.4"></script>
	</body>
</html>
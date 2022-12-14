<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	if (session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="icon" type="image/png" href="../assets/img/favicon.ico">
		<title>
		Sign up
		</title>
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
	</head>
	<body>
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
								<form id="signupForm" action="<%=request.getContextPath() %>/member/insertLoginAction.jsp" method="post">
									<div class="mb-3">
										<input type="text" id="name" name="memberName" class="form-control" placeholder="Name" aria-label="Name">
									</div>
									<div class="mb-3">
										<input type="text" id="id" name="memberId" class="form-control" placeholder="Id" aria-label="Id">
									</div>
									<div class="mb-3">
										<input type="password" id="pw1" name="memberPw1" class="form-control" placeholder="Password" aria-label="Password">
									</div>
									<div class="mb-3">
										<input type="password" id="pw2" name="memberPw2" class="form-control" placeholder="Password" aria-label="Password">
									</div>
									<div class="form-check form-check-info text-start">
										<input class="form-check-input" type="checkbox">
										<label class="form-check-label">
											I agree the <a href="" class="text-dark font-weight-bolder">Terms and Conditions</a><!-- 개인정보동의 페이지 만들어두기 -->
										</label>
									</div>
									<div class="text-center">
										<button type="button" id="signupBtn" class="btn bg-gradient-dark w-100 my-4 mb-2">회원가입</button>
									</div>
									<p class="text-sm mt-3 mb-0">
										Already have an account? <a href="<%=request.getContextPath() %>/log/loginForm.jsp" class="text-dark font-weight-bolder">로그인</a>
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
		<!-- 유효성 검사 -->
		<script>
			let signupBtn = window.document.querySelector("#signupBtn");
			signupBtn.addEventListener('click', function() {
				// 디버깅
				console.log('signupBtn Click');
				
				// 이름 유효성(공백) 검사
				let name = window.document.querySelector('#name');
				if(name.value == '') {
					alert('이름을 확인해주세요')
					name.focus();
					return;
				}
				
				// ID 유효성(공백) 검사
				let id = window.document.querySelector('#id');
				if(id.value == '') {
					alert('아이디를 확인해주세요')
					id.focus();
					return;
				}
				
				// 비밀번호 유효성(공백, 일치) 검사
				let pw1 = window.document.querySelector('#pw1');
				let pw2 = window.document.querySelector('#pw2');
				if(pw1.value == '' || pw1.value != pw2.value) {
					alert('비밀번호를 확인해주세요')
					pw1.focus();
					return;
				}
				
				// 개인정보동의 유효성 검사
				let ck = document.querySelectorAll('.form-check-input:checked');
				console.log(ck);
				if(ck.length != 1) {
					alert('약관에 동의하세요');
					// $('#ckBtn').focus();
					return;
				}
				
				// 유효성검사 통과하면 insertLoginAction.jsp로 넘어감
				let signupForm = document.querySelector('#signupForm');
				signupForm.submit();
			});
		</script>
	</body>
</html>
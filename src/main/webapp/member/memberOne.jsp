<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");
	
	//세션에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="position-absolute w-100 min-height-300 top-0" style="background-image: url('https://raw.githubusercontent.com/creativetimofficial/public-assets/master/argon-dashboard-pro/assets/img/profile-layout-header.jpg'); background-position-y: 50%;">
			<span class="mask bg-primary opacity-6"></span>
		</div>
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
		<div class="main-content position-relative max-height-vh-100 h-100">
			<div class="card shadow-lg mx-4 card-profile-bottom">
				<div class="card-body p-3">
					<div class="row">
						<div class="col-auto">
							<div class="avatar avatar-xl position-relative">
								<img src="../assets/img/team-1.jpg" alt="profile_image" class="w-100 border-radius-lg shadow-sm">
							</div>
						</div>
						<div class="col-auto my-auto">
							<div class="h-100">
								<h5 class="mb-1">
								<%=loginMember.getMemberId() %>
								</h5>
								<p class="mb-0 font-weight-bold text-sm">
								<%=loginMember.getMemberName() %>
								</p>
							</div>
						</div>
						<div class="col-auto ms-auto text-end">
							<button type="button" class="btn bg-gradient-primary " data-bs-toggle="modal" data-bs-target="#exampleModal" style="float:right;">회원탈퇴</button>
							<form action="<%=request.getContextPath() %>/member/deleteMemberAction.jsp">
							<!-- Modal -->
								<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">정말 탈퇴하시겠습니까?</h5>
											</div>
											<div class="modal-body">
												<input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>" readonly="readonly">
												<input type="password" name="memberPw" class="form-control" placeholder="비밀번호를 입력해주세요">
											</div>
											<div class="modal-footer">
												<button type="submit" class="btn bg-gradient-primary" data-bs-dismiss="modal" aria-label="Close">아니오</button>
												<button type="submit" class="btn bg-gradient-secondary">탈퇴</button>
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="container-fluid py-4">
				<div class="row">
					<div class="col-md-12">
						<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="get">
							<div class="card" style="height: 350px;">
								<div class="card-header pb-0">
									<div class="row">
										<div class="col-6 d-flex align-items-center">
											<p class="mb-0">정보수정</p>
										</div>
										<div class="col-6 text-end">
											<button class="btn bg-gradient-primary btn-sm" type="submit">정보 수정</button>
											<a class="btn bg-gradient-primary btn-sm" href="<%=request.getContextPath() %>/member/deleteMemberForm.jsp">회원 탈퇴</a> <!-- modal로 구현 -->
											
										</div>
									</div>
									<div class="card-body">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label for="example-text-input" class="form-control-label">Name</label> <input class="form-control" type="text" name="memberName" value="<%=loginMember.getMemberName() %>">
												</div>
											</div>					
											<div class="col-md-6">
												<div class="form-group">
													<label for="example-text-input" class="form-control-label">ID</label> <input class="form-control" type="text" name="memberId" value="<%=loginMember.getMemberId() %>">
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label for="example-text-input" class="form-control-label">PASSWORD</label> <input class="form-control" type="password" name="memberPw">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<script src="https://demos.creative-tim.com/soft-ui-design-system-pro/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
	</body>
</html>
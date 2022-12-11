<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	//접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 일반회원일 경우
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 내용 미입력시 경고창 출력
	String msg = request.getParameter("msg");
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
		<style>
			table {
				border-collapse: separate;
				border-spacing: 20px;
			}
			
			textarea {
				height: 550px;
				resize: none;	
			}
			
			input {
				height: 60px;
				font-size: 15px;
			}
		</style>
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
						<div class="pb-4">
							<h4>공지 등록</h4>
						</div>
						<div class="card-body px-0 pt-0 pb-0">
							<form action="<%=request.getContextPath() %>/admin/notice/insertNoticeAction.jsp" method="post">
								<table>
									<tr>
										<td></td>
										<td>
										<%
											if(msg != null) {
										%>
												<span><%=msg %></span>
										<%
											} else { // 화면 비율을 맞추기 위해
										%>
												&nbsp;
										<%
											}
										%>
										</td>
									</tr>
									<tr>
										<th>제목</th>
										<td><input class="form-control"  type="text" name="noticeTitle"></td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea class="form-control" cols="200" name="noticeMemo"></textarea></td>
									</tr>
									<tr>
										<td></td>
										<td>
											<button type="submit" class="btn bg-gradient-primary btn-lg w-100">add</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
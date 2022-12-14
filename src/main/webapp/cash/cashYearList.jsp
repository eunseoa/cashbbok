<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller

	// 비로그인시 접근금지
	if(session.getAttribute("loginMember") == null) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	// 로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	// Model 호출
	// 년도별 수입 지출합계 리스트 출력
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashYearList(loginMember.getMemberId());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>CashBook</title>
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			th {
				height: 50px;
			}
			
			td {
				height: 60px;
			}
			
			th:nth-child(n+2):nth-child(-n+4), td:nth-child(n+2):nth-child(-n+4) {
				color: #6799FF;
			}
			
			th:nth-child(n+5), td:nth-child(n+5) {
				color: #FF7E7E;
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
								<h4 class="mb-0">년도별 통계</h4>
							</div>
							<div class="col-6 text-end">
								<a href="<%=request.getContextPath() %>/member/help/insertHelpForm.jsp" class="btn bg-gradient-primary btn-lg">월별 통계</a>
							</div>
						</div>
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<table class="table align-items-center mb-0">
								<tr>
									<th>년도</th>
									<th>수입카운트</th>
									<th>수입합계</th>
									<th>수입평균</th>
									<th>지출카운트</th>
									<th>지출합계</th>
									<th>지출평균</th>
								</tr>
								<tr>
								<%
									for(HashMap<String, Object> c : list) {
								%>
										<td><%=c.get("year") %></td>
										<td><%=c.get("importCashCnt") %></td>
										<td><%=c.get("importCashSum") %></td>
										<td><%=c.get("importCashAvg") %></td>
										<td><%=c.get("exportCashCnt") %></td>
										<td><%=c.get("exportCashSum") %></td>
										<td><%=c.get("exportCashAvg") %></td>
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
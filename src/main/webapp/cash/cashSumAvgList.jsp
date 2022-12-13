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
	
	// 페이징
	int year = 0;
	
	if(request.getParameter("year") == null) {
		Calendar today = Calendar.getInstance();// 현재날짜를 저장
		year = today.get(Calendar.YEAR); // 년도만 저장
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}
	
	// Model 호츌
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashSumAvgByMonthList(year, loginMember.getMemberId());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>고객센터</title>
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			th {
				width: 300px;
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
								<h4 class="mb-0">내가 작성한 문의글</h4>
							</div>
							<div class="col-6 text-end">
								<a href="<%=request.getContextPath() %>/member/help/insertHelpForm.jsp" class="btn bg-gradient-primary btn-lg">문의하기</a>
							</div>
						</div>
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<table class="table align-items-center mb-0">
								<tr>
									<th>월별</th>
									<th>수입Cnt(개)</th>
									<th>수입합계</th>
									<th>수입평균</th>
									<th>지출Cnt</th>
									<th>지출합계</th>
									<th>지출평균</th>
								</tr>
								<tr>
								<%
									for(HashMap<String, Object> c : list) {
								%>
										<td><%=c.get("month") %></td>
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
								<tr>
									<td colspan="2">
										<a href="<%=request.getContextPath() %>/cash/cashSumAvgList.jsp?year=<%=year - 1 %>">이전년도</a>
										<a href="<%=request.getContextPath() %>/cash/cashSumAvgList.jsp?year=<%=year + 1 %>">다음년도</a>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller : session, rquest
	request.setCharacterEncoding("utf-8");

	// 비로그인시 접근금지
	if(session.getAttribute("loginMember") == null) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 세션에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = ((Member) session.getAttribute("loginMember"));
	
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR); // 오늘날짜의 년도
		month = today.get(Calendar.MONTH); // 오늘날짜의 달
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		if (month == -1) { // 1월달에서 이전달을 누르면
			month = 11; 
			year--; 
		}
		if (month == 12) { // 12월달에서 다음달을 누르면
			month = 0;
			year++; 
		}
	}

	// 출력하고자 하는 년,월과 1일의 요일 (일 1, 월2, ..)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 1일의 요일 정보
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 해당 달의 마지막날짜
	
	// 달력의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // 나누어 떨어지면 0
	if((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7); // 7 - 나머지
	}
	
	int totalTd = beginBlank + lastDate + endBlank; // 전체 td의 개수
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	
	// Vew : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashList</title>
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			td {
				width : 180px;
				height : 180px;
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
		<main class="main-content position-relative border-radius-lg">
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
				<div class="row">
					<div class="col-xl-3 col-sm-6">
						<div class="card">
							<div class="card-body p-3">
								<div class="row">
									<div class="col-9">
										<div class="numbers">
											<p class="text-sm mb-0 text-uppercase font-weight-bold"><%=month + 1 %>월 총 수입</p>
											<h5 class="font-weight-bolder">100원</h5>
										</div>
									</div>
									<div class="col-3 text-end">
										<div class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
											<i class="ni ni-money-coins text-lg opacity-10" aria-hidden="true"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6">
						<div class="card">
							<div class="card-body p-3">
								<div class="row">
									<div class="col-9">
										<div class="numbers">
											<p class="text-sm mb-0 text-uppercase font-weight-bold"><%=month + 1 %>월 총 지출</p>
											<h5 class="font-weight-bolder">100원</h5>
										</div>
									</div>
									<div class="col-3 text-end">
										<div class="icon icon-shape bg-gradient-danger shadow-danger text-center rounded-circle">
											<i class="ni ni-credit-card text-lg opacity-10" aria-hidden="true"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6">
						<div class="card">
							<div class="card-body p-3">
								<div class="row">
									<div class="col-9">
										<div class="numbers">
											<p class="text-sm mb-0 text-uppercase font-weight-bold"><%=month + 1 %>월 총 저축</p>
											<h5 class="font-weight-bolder">100원</h5>
										</div>
									</div>
									<div class="col-3 text-end">
										<div class="icon icon-shape bg-gradient-success shadow-success text-center rounded-circle">
											<i class="ni ni-favourite-28 text-lg opacity-10" aria-hidden="true"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-sm-6">
						<div class="card">
							<div class="card-body p-3">
								<div class="row">
									<div class="col-9">
										<div class="numbers">
											<p class="text-sm mb-0 text-uppercase font-weight-bold">많이 사용한 카테고리</p>
											<h5 class="font-weight-bolder">$103,430</h5>
										</div>
									</div>
									<div class="col-3 text-end">
										<div class="icon icon-shape bg-gradient-warning shadow-warning text-center rounded-circle">
											<i class="ni ni-bullet-list-67 text-lg opacity-10" aria-hidden="true"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card mt-4" style="height: 1035px;">
					<div class="card-header pb-0">
						<div class="pb-4">
							<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month - 1%>"><i class="ni ni-bold-left"></i></a>
							<%=year%>년 <%=month + 1%>월
							<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month + 1%>"><i class="ni ni-bold-right"></i></a>
						</div>
						<div class="card-body px-0 pt-0 pb-0">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">일요일</th>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">월요일</th>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">화요일</th>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">수요일</th>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">목요일</th>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">금요일</th>
										<th class="text-center text-uppercase text-secondary font-weight-bolder">토요일</th>
									</tr>
								</thead>
								<tbody>
									<tr>
									<!-- 달력 -->
									<%
										for (int i=1; i<=totalTd; i++) {
									%>
											<td class="align-top">
									<%
												int date = i - beginBlank;
												if (date > 0 && date <= lastDate) {
									%>		
													<div>
														<a href="<%=request.getContextPath() %>/cash/cashDateList.jsp?year=<%=year %>&month=<%=month+1 %>&date=<%=date %>"><%=date %></a>
													</div>
														<div>
															<%
																for(HashMap<String, Object> m : list) {
																	String cashDate = (String)(m.get("cashDate"));
																	if(Integer.parseInt(cashDate.substring(8)) == date) {
																		if(m.get("categoryKind").equals("수입")) {
															%>
																			<i class="ni ni-fat-add" style="color: #6799FF"></i>
															<%
																		} else {
															%>
																			<i class="ni ni-fat-delete" style="color: #FF7E7E"></i>
															<%
																		}
															%>
																			
																			<%=(String)m.get("categoryName") %>
																			&nbsp;
																			<%=(Long)m.get("cashPrice") %>원
																			<br>
															<%	
																	}
																}
															%>
														</div>
											</td>
									<%
												}
									
											if(i % 7 == 0 && i != totalTd) {
									%>
												</tr><tr> 
									<%
											}
										}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
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
	
	// Model 호출
	CashDao cashDao = new CashDao();
	// 일별 cash 목록
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	// 월별 수익, 지출 합계
	HashMap<String, Object> importCash = cashDao.cashListByMonth(year, month+1, loginMember.getMemberId());
	// 월별 수익, 지출 통계 list 
	ArrayList<HashMap<String, Object>> cashList = cashDao.selectCashSumAvgByMonthIntList(year, loginMember.getMemberId());
	// 배열
	int[] arr = new int[12];
	for(int i=0; i<arr.length; i++) {
		for(HashMap<String, Object> cash : cashList) {
			arr[i] = (Integer)cash.get("importCashSum");
		}
	}
	
	System.out.println(arr[0]);
	// Vew : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<title>
		  Main
		</title>
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			td {
				height: 130px;
			}
			
			.text-sm {
				overflow-y: hidden;
				text-overflow: ellipsis;
				max-height: 80px;
			}
		</style>
	</head>
	<body class="g-sidenav-show   bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByMember.jsp"></jsp:include>
		<main class="main-content position-relative border-radius-lg ">
			<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
				<div class="container-fluid py-1 px-3">
					<div class="ms-md-auto pe-md-3 d-flex align-items-center"></div>
					<ul class="navbar-nav  justify-content-end">
						<li class="nav-item d-flex align-items-center">
							<div class="nav-link text-white font-weight-bold px-0">
								<i class="fa fa-user me-sm-1"></i> <span class="d-sm-inline d-none"><%=loginMember.getMemberId() %>, welcome!</span>
							</div>
						</li>
					</ul>
				</div>
			</nav>
			<div class="container-fluid py-4">
				<div class="row">
					<div class="col-lg-8">
						<div class="row">
							<div class="col-xl-12">
								<div class="row">
									<div class="col-xl-6 col-sm-6">
										<div class="card">
											<div class="card-body p-3">
												<div class="row">
													<div class="col-9">
														<div class="numbers">
															<p class="text-sm mb-0 text-uppercase font-weight-bold"><%=month + 1 %>월 총 수입</p>
															<h5 class="font-weight-bolder"><%=importCash.get("importCash") %>원</h5>
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
									<div class="col-xl-6 col-sm-6">
										<div class="card">
											<div class="card-body p-3">
												<div class="row">
													<div class="col-9">
														<div class="numbers">
															<p class="text-sm mb-0 text-uppercase font-weight-bold"><%=month + 1 %>월 총 지출</p>
															<h5 class="font-weight-bolder"><%=importCash.get("exportCash") %>원</h5>
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
								</div>
							</div>
							<div class="col-md-12 mb-lg-0 mb-4">
								<div class="row mt-4">
									<div class="col-lg-12">
										<div class="card" style="height: 800px;">
											<div class="card-header">
												<div class="row">
													<div class="col-6 d-flex align-items-center">
														<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month - 1%>"><i class="ni ni-bold-left"></i></a>
													<%=year%>년 <%=month + 1%>월
													<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month + 1%>"><i class="ni ni-bold-right"></i></a>
													</div>
													<div class="col-6 text-end">
														<a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="btn btn-outline-primary btn-sm mb-0">가계부</a>
													</div>
												</div>
												<div class="card-body px-0 pt-0 pb-0">
													<table class="table align-items-center mb-0" style="width: 850px;">
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
																				<div class="text-sm">
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
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="row">
							<div class="col-lg-12 mb-lg-0 mb-4">
								<div class="card z-index-2 h-100">
									<div class="card-header pb-0 pt-3 bg-transparent">
										<h6 class="text-capitalize">Sales overview</h6>
									</div>
									<div class="card-body p-3">
										<div class="chart">
											<canvas id="chart-line" class="chart-canvas" height="300"></canvas>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card h-100 mt-4">
							<div class="card-header pb-0 p-3">
								<div class="row">
									<div class="col-6 d-flex align-items-center">
										<h6 class="mb-0"><!-- 그래프.. --></h6>
									</div>
								</div>
							</div>
							<div class="card-body p-3 pb-0">
								<ul class="list-group">
									<li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
		<script src="../assets/js/core/popper.min.js"></script>
		<script src="../assets/js/core/bootstrap.min.js"></script>
		<script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
		<script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
		<script src="../assets/js/plugins/chartjs.min.js"></script>
		<script>
			var ctx1 = document.getElementById("chart-line").getContext("2d");
	
			var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);
	
			gradientStroke1.addColorStop(1, 'rgba(94, 114, 228, 0.2)');
			gradientStroke1.addColorStop(0.2, 'rgba(94, 114, 228, 0.0)');
			gradientStroke1.addColorStop(0, 'rgba(94, 114, 228, 0)');
			new Chart(ctx1, {
				type : "line",
				data : {
					labels : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월",
							"8월", "9월", "10월", "11월", "12월" ],
					datasets : [ {
						label : "Mobile apps",
						tension : 0.4,
						borderWidth : 0,
						pointRadius : 0,
						borderColor : "#5e72e4",
						backgroundColor : gradientStroke1,
						borderWidth : 3,
						fill : true,
						data : [ <%=arr[0] %>, <%=arr[1] %>, <%=arr[2] %>, <%=arr[3] %>, <%=arr[4] %>, <%=arr[5] %>, <%=arr[6] %>, <%=arr[7] %>, <%=arr[8] %>, <%=arr[9] %>, <%=arr[10] %>, <%=arr[11] %> ],
						maxBarThickness : 6
	
					} ],
				},
				options : {
					responsive : true,
					maintainAspectRatio : false,
					plugins : {
						legend : {
							display : false,
						}
					},
					interaction : {
						intersect : false,
						mode : 'index',
					},
					scales : {
						y : {
							grid : {
								drawBorder : false,
								display : true,
								drawOnChartArea : true,
								drawTicks : false,
								borderDash : [ 5, 5 ]
							},
							ticks : {
								display : true,
								padding : 10,
								color : '#fbfbfb',
								font : {
									size : 11,
									family : "Open Sans",
									style : 'normal',
									lineHeight : 2
								},
							}
						},
						x : {
							grid : {
								drawBorder : false,
								display : false,
								drawOnChartArea : false,
								drawTicks : false,
								borderDash : [ 5, 5 ]
							},
							ticks : {
								display : true,
								color : '#ccc',
								padding : 20,
								font : {
									size : 11,
									family : "Open Sans",
									style : 'normal',
									lineHeight : 2
								},
							}
						},
					},
				},
			});
		</script>
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
		<script src="../../assets/js/plugins/chartjs.min.js"></script>
	</body>
</html>
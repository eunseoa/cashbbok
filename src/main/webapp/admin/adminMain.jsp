<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 로그인정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	//접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 일반회원일 경우
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// cashList
	int year = 0;
	int month = 0;
	
	// 로그인한 당시의 달만 출력
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR); // 오늘날짜의 년도
		month = today.get(Calendar.MONTH); // 오늘날짜의 달
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
	// 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	
	// 최근 공지 5개
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(0, 5);

	// 최근 멤버 5명
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> memberList = memberDao.selectMemberByPage(0, 5);
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
				width: 50px;
				height: 110px;
			}
		</style>
	</head>
	<body class="g-sidenav-show   bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByAdmin.jsp"></jsp:include>
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
									<div class="col-md-4">
										<div class="card">
											<div class="card-header mx-4 p-3 text-center">
												<div class="icon icon-shape icon-lg bg-gradient-primary shadow text-center border-radius-lg">
													<i class="fas fa-money-bill opacity-10"></i>
												</div>
											</div>
											<div class="card-body pt-0 p-3 text-center">
												<h6 class="text-center mb-0"><%=month + 1 %> 월 총 수입</h6>
												<span class="text-xs">&nbsp;</span>
												<hr class="horizontal dark my-3">
												<h5 class="mb-0">원</h5>
											</div>
										</div>
									</div>
									<div class="col-md-4 mt-md-0 mt-4">
										<div class="card">
											<div class="card-header mx-4 p-3 text-center">
												<div class="icon icon-shape icon-lg bg-gradient-primary shadow text-center border-radius-lg">
													<i class="fa fa-credit-card opacity-10"></i>
												</div>
											</div>
											<div class="card-body pt-0 p-3 text-center">
												<h6 class="text-center mb-0"><%=month + 1 %> 월 총 지출</h6>
												<span class="text-xs">&nbsp;</span>
												<hr class="horizontal dark my-3">
												<h5 class="mb-0">원</h5>
											</div>
										</div>
									</div>
									<div class="col-md-4 mt-md-0 mt-4">
										<div class="card">
											<div class="card-header mx-4 p-3 text-center">
												<div class="icon icon-shape icon-lg bg-gradient-primary shadow text-center border-radius-lg">
													<i class="fa fa-wallet opacity-10"></i>
												</div>
											</div>
											<div class="card-body pt-0 p-3 text-center">
												<h6 class="text-center mb-0"><%=month + 1 %> 월 총 저축</h6>
												<span class="text-xs">&nbsp;</span>
												<hr class="horizontal dark my-3">
												<h5 class="mb-0">원</h5>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-12 mb-lg-0 mb-4">
								<div class="row mt-4">
									<div class="col-lg-12">
										<div class="card" style="height: 700px;">
											<div class="card-header">
												<div class="row">
													<div class="col-6 d-flex align-items-center">
														<h6 class="mb-0"><%=year %>년 <%=month+1 %>월</h6>
													</div>
													<div class="col-6 text-end">
														<a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="btn btn-outline-primary btn-sm mb-0">가계부</a>
													</div>
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
																				<div class="text-sm">
																					<%
																						for(HashMap<String, Object> m : list) {
																							String cashDate = (String)(m.get("cashDate"));
																							if(Integer.parseInt(cashDate.substring(8)) == date) {
																					%>
																					[<%=(String)m.get("categoryKind") %>]
																					<%=(String)m.get("categoryName") %>
																					&nbsp; <br>
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
																			</tr>
																			<tr>
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
							<div class="card h-100">
								<div class="card-header pb-3 p-3">
									<div class="row">
										<div class="col-6 d-flex align-items-center">
											<h6 class="mb-0"><a href="<%=request.getContextPath() %>/notice/noticeList.jsp">최근 공지</a></h6>
										</div>
										<div class="col-6 text-end">
											<a href="<%=request.getContextPath() %>/notice/noticeList.jsp" class="btn btn-outline-primary btn-sm mb-0">공지</a>
										</div>
									</div>
								</div>
								<div class="card-body p-3 pb-0">
									<ul class="list-group">
									<%
										for(Notice n : noticeList) {
									%>
											<li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
												<div class="d-flex flex-column">
													<h6 class="mb-1 text-dark font-weight-bold text-sm">
														<a href="<%=request.getContextPath() %>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a>
													</h6>
													<span class="text-xs">#MS-415646</span>
												</div>
												<div class="d-flex align-items-center text-sm">
													<%=n.getCreatedate() %>
												</div>
											</li>
									<%
										}
									%>
									</ul>
								</div>
							</div>
							<div class="card h-100 mt-4">
								<div class="card-header pb-0 p-3">
									<div class="row">
										<div class="col-6 d-flex align-items-center">
											<h6 class="mb-0"><a href="<%=request.getContextPath() %>/admin/member/memberList.jsp">최근 가입 멤버</a></h6>
										</div>
										<div class="col-6 text-end">
											<a href="<%=request.getContextPath() %>/admin/member/memberList.jsp" class="btn btn-outline-primary btn-sm mb-0">멤버리스트</a>
										</div>
									</div>
								</div>
								<div class="card-body p-3 pb-0">
									<ul class="list-group">
									<%
										for(Member m : memberList) {
									%>
											<li class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2 border-radius-lg">
												<div class="d-flex flex-column">
													<h6 class="mb-1 text-dark font-weight-bold text-sm"><%=m.getMemberId() %> · <%=m.getMemberName() %></h6>
													<span class="text-xs">
													<%
														if(m.getMemberLevel() < 1) {
													%>
															일반회원
													<%
														} else {
													%>
															관리자
													<%
														}
													%>
													</span>
												</div>
												<div class="d-flex align-items-center text-sm">
													<%=m.getUpdatedate() %>
												</div>
											</li>
									<%
										}
									%>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
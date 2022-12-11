<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 로그인 정보 저장
	Member loginMember = (Member)session.getAttribute("loginMember");

	// 비로그인시 접근금지
	if(loginMember == null) {
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 정상적인 접근이 아닐때
	if (request.getParameter("year") == null || request.getParameter("year").equals("")
		|| request.getParameter("month") == null || request.getParameter("month").equals("")
		|| request.getParameter("date") == null || request.getParameter("date").equals("")
		|| request.getParameter("cashNo") == null || request.getParameter("cashNo").equals("")) {
		out.println("<script>alert('오류'); location.href='" + request.getContextPath() + "/cash/cashList.jsp" + "';</script>");
		return;
	}
	
	// 내용미입력시 경고창출력
	String msg = request.getParameter("msg");
	
	String memberId = loginMember.getMemberId();
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	// Model 호출
	// 카테고리 출력
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash 목록 출력
	Cash cash = new Cash();
	cash.setMemberId(memberId);
	cash.setCashNo(cashNo);
	
	CashDao cashDao = new CashDao();
	Cash updateList = cashDao.selectUpdateCashOne(cash);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>CashDate</title>
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			table {
				border-collapse: separate;
				border-spacing: 20px;
			}
			
			th {
				width: 150px;
			}
			
			input {
				height: 60px;
			}
		</style>
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<%
			if(loginMember.getMemberLevel() < 1) {
		%>
				<jsp:include page="/inc/sidebarByMember.jsp"></jsp:include>
		<%
			} else {
		%>
				<jsp:include page="/inc/sidebarByAdmin.jsp"></jsp:include>
		<%
			}
		%>
		<main class="main-content position-relative border-radius-lg ">
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
				<div class="card" style="height: 600px;">
					<div class="card-header">
						<div class="col-6 d-flex align-items-center">
							<h6 class="mb-0">내역 수정</h6>
						</div>
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<ul class="list-group">
								<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
									<form action="<%=request.getContextPath() %>/cash/updateCashAction.jsp?cashNo=<%=updateList.getCashNo() %>&year=<%=year %>&month=<%=month %>&date=<%=date %>" method="post">
										<div class="d-flex flex-column" style="width:1450px;">
											<table>
												<tr>
													<td colspan="2">
													<%
														if(msg != null) {
													%>
															<p style="color: red"><%=msg %></p>
													<%
														} else {
													%>
													
													<%
														}
													%>
													</td>
												</tr>
												<tr>
													<th>날짜</th>
													<td><input type="text" name="cashDate" class="form-control" value="<%=year %>-<%=month %>-<%=date %>" readonly="readonly"></td>
												</tr>
												<tr>
													<th>수입/지출</th>
													<td>
														<select name="categoryNo" class="form-select">
															<%
																for(Category c : categoryList) {
															%>
																	<option value="<%=c.getCategoryNo()%>"
															<%
																		if(c.getCategoryNo() == categoryNo) {
															%>
																			selected
															<%
																		} else {
																			
																		}
															%>>
																		<%=c.getCategoryKind() %> <%=c.getCategoryName() %>
																	</option>
															<%
																}
															%>
														</select>
													</td>
												</tr>
												<tr>
													<th>금액</th>
													<td><input type="text" class="form-control" name="cashPrice" value="<%=updateList.getCashPrice() %>"></td>
												</tr>
												<tr>
													<th>메모</th>
													<td><input type="text" class="form-control" name="cashMemo" value="<%=updateList.getCashMemo() %>"></td>
												</tr>
												<tr>
													<td></td>
													<td><button type="submit" class="btn bg-gradient-primary btn-lg w-100">수정</button></td>
												</tr>
											</table>
										</div>
									</form>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
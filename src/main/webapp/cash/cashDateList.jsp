<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	if(request.getParameter("year") == null || request.getParameter("year").equals("")
		|| request.getParameter("month") == null || request.getParameter("month").equals("")
		|| request.getParameter("date") == null || request.getParameter("date").equals("")) {
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// Model 호출
	// 카테고리 목록 출력
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// cash 목록 출력
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
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
		<style>
			table {
				border-collapse: separate;
				border-spacing: 20px;
			}
			
			textarea {
				height: 150px;
				resize: none;	
			}
			
			input {
				height: 32px;
				font-size: 15px;
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
	    <!-- End Navbar -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-7 mt-4">
						<div class="card">
							<div class="card-header pb-0 px-3">
								<div class="row">
									<div class="col-md-6">
										<h6 class="mb-0">List</h6>
									</div>
									<div class="col-md-6 d-flex justify-content-end align-items-center">
										<i class="far fa-calendar-alt me-2"></i>
										<small><%=year %> / <%=month %> / <%=date %></small>
									</div>
								</div>	
							</div>
							<div class="card-body pt-4 p-3">
							<%
								for(HashMap<String, Object> m : list) {
									String cashDate = (String)m.get("cashDate");
									System.out.println(cashDate);
									if(Integer.parseInt(cashDate.substring(8)) == date) {
									int cashNo = (Integer)(m.get("cashNo"));
									System.out.println(cashNo);
									int categoryNo = (Integer)(m.get("categoryNo"));
									System.out.println(categoryNo); 
							%>
								<ul class="list-group">
									<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
										<div class="d-flex flex-column" style="width:500px;">
											<h6 class="mb-3 text-sm"><%=(String)(m.get("categoryKind")) %></h6>
											<span class="mb-2 text-sm">categoryName: <span class="text-dark font-weight-bold ms-sm-2"><%=(String)(m.get("categoryName")) %></span></span>
											<span class="mb-2 text-sm">cashPrice <span class="text-dark ms-sm-2 font-weight-bold"><%=(Long)(m.get("cashPrice")) %>원</span></span>
											<span class="mb-2 text-sm">memo <span class="text-dark ms-sm-2 font-weight-bold"><%=(String)(m.get("cashMemo")) %></span></span>
										</div>
										<div class="ms-auto text-end">
											<a class="btn btn-link text-danger text-gradient px-3 mb-0" href="<%=request.getContextPath() %>/cash/deleteCashAction.jsp?cashNo=<%=cashNo %>&categoryNo=<%=categoryNo %>&year=<%=year %>&month=<%=month %>&date=<%=date %>">
												<i class="far fa-trash-alt"></i>
											</a>
											<a class="btn btn-link text-dark px-3 mb-0" href="<%=request.getContextPath() %>/cash/updateCashForm.jsp?cashNo=<%=cashNo %>&categoryNo=<%=categoryNo %>&year=<%=year %>&month=<%=month %>&date=<%=date %>">
												<i class="fas fa-pencil-alt text-dark"></i>
											</a>
										</div>
									</li>
								</ul>
							<%
									}
								}
							%>
							</div>
						</div>
					</div>
					<div class="col-md-5 mt-4" style="height: 470px;">
						<div class="card h-100 mb-4">
							<div class="card-header pb-0 px-3">
								<div class="row">
									<div class="col-md-6">
										<h6 class="mb-0">Add</h6>
									</div>
									<div class="col-md-6 d-flex justify-content-end align-items-center">
										<i class="far fa-calendar-alt me-2"></i>
										<small><%=year %> / <%=month %> / <%=date %></small>
									</div>
								</div>
							</div>
							<form action="<%=request.getContextPath() %>/cash/insertCashAction.jsp" method="post">
								<div class="card-body pt-4 p-3">
									<table> 
						 				<tr>  
						 					<td>
						 						<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
						 						<input type="hidden" name="cashDate" value="<%=year %>-<%=month %>-<%=date %>">
						 						<input type="hidden" name="year" value="<%=year %>">
												<input type="hidden" name="month" value="<%=month %>">
												<input type="hidden" name="date" value="<%=date %>">
						 					</td>
						 				</tr>
						 				<tr>
						 					<td>카테고리</td>
						 					<td>
						 						<select class="form-select" name="categoryNo">
													<%
						 								for(Category c : categoryList) {
													%>
															<option value="<%=c.getCategoryNo() %>">
																<%=c.getCategoryKind() %> <%=c.getCategoryName() %>
															</option>
													<%
						 								}
													%>
												</select>
											</td>
										</tr>
										<tr>
											<td>cashPrice</td>
											<td>
												<input class="form-control" type="text" name="cashPrice">
											</td>
										</tr>
										<tr>
											<td>cashMemo</td>
											<td>
												<textarea class="form-control" cols="58" name="cashMemo"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2" style="text-align:right;">
												<button type="submit" class="btn btn-primary ms-auto">add</button>
											</td>
										</tr>
									</table>
								</div>
							</form>     
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
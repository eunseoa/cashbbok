<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>sidebar</title>
	</head>
	<body>
		<aside class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 " id="sidenav-main">
			<div class="sidenav-header">
				<i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
				<a class="navbar-brand m-0" href="<%=request.getContextPath() %>/cash/cashList.jsp" target="_blank">
					<span class="ms-1 font-weight-bold">CashBook</span>
				</a>
			</div>
			<hr class="horizontal dark mt-0">
			<div class="collapse navbar-collapse w-auto " id="sidenav-collapse-main">
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/member/memberMain.jsp">
							<span class="icon">
							<i class="ni ni-favourite-28 text-sm opacity-10" style="color: #4641D9"></i>
							</span>
							<span class="nav-link-text ms-1">Main</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/cash/cashList.jsp">
							<span class="icon">
								<i class="ni ni-money-coins text-sm opacity-10" style="color: #6B66FF"></i>
							</span>
							<span class="nav-link-text ms-1">CashBook</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/member/help/helpMain.jsp">
							<span class="icon">
								<i class="ni ni-chat-round text-sm opacity-10" style="color: #6799FF"></i>
							</span>
							<span class="nav-link-text ms-1">Q &amp; A</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/notice/noticeList.jsp">
							<span class="icon">
								<i class="ni ni-archive-2 text-sm opacity-10" style="color: #B2CCFF"></i>
							</span>
							<span class="nav-link-text ms-1">Notice</span>
						</a>
					</li>
					<li class="nav-item mt-3">
						<h6 class="ps-4 ms-2 text-xs font-weight-bolder opacity-6">My Page</h6>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/member/memberOne.jsp">
							<span class="icon">
							<i class="ni ni-badge text-dark text-sm opacity-10"></i>
							</span>
							<span class="nav-link-text ms-1">Profile</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath() %>/log/logout.jsp">
							<span class="icon">
								<i class="ni ni-settings-gear-65 text-dark text-sm opacity-10"></i>
							</span>
							<span class="nav-link-text ms-1">Logout</span>
						</a>
					</li>
				</ul>
			</div>
		</aside>      
	</body>
</html>
      
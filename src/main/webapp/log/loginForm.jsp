<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// Cotroller
	request.setCharacterEncoding("utf-8");
	
	if (session.getAttribute("loginMember") != null) {
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 입력하지않은 항목이 있을때
	String msg = request.getParameter("msg");
	
	// Model 호출
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// 마지막페이지
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	if (lastPage % rowPerPage != 0) {
		lastPage++;
	}

	// View
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<title>
			Sign in
		</title>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
	</head>
	<body>
		<main class="main-content">
			<div class="page-header min-vh-100">
				<div class="container">
					<div class="row">
						<div class="col-xl-4 col-lg-5 d-flex flex-column">
							<div class="card card-plain">
								<div class="card-header pb-0 text-start">
									<h4 class="font-weight-bolder">Sign In</h4>
									<p class="mb-0">Enter your id and password to sign in</p>
								</div>
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/log/loginAction.jsp" method="post">
										<div class="mb-3">
											<input type="text" class="form-control form-control-lg" name="memberId" placeholder="id" aria-label="id">
										</div>
										<div class="mb-3">
											<input type="password" class="form-control form-control-lg" name="memberPw" placeholder="Password" aria-label="Password">
										</div>
										<div>
										<%
											if(msg != null) {
										%>
												<p class="mb-0" style="color:red;"><%=msg %></p>
										<%
											} else {
										%>
												&nbsp;
										<%
											}
										%>
										</div>
										<div class="text-center">
											<button type="submit" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Sign in</button>
										</div>
									</form>
								</div>
								<div class="card-footer text-center pt-0 px-lg-2 px-1">
									<p class="mb-4 text-sm mx-auto">
										Don't have an account? <a href="<%=request.getContextPath()%>/member/insertLoginForm.jsp" class="text-primary text-gradient font-weight-bold">Sign up</a>
									</p>
								</div>
							</div>
						</div>
						<div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 end-0 text-center justify-content-center flex-column">
							<div class="position-relative h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center">
								<table>
									<tr>
										<th>최근 공지 내용</th>
										<th>등록 일자</th>
									</tr>
									<%
										for (Notice n : list) {	
											String createdate = (String)(n.getCreatedate());
									%>
										<tr>
											<td><a href="<%=request.getContextPath() %>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
											<td><%=createdate.substring(0, 10)%></td>
										</tr>
									<%
										}
									%>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
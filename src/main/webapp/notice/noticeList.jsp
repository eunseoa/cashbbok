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
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출 : noticeList
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// 마지막페이지
	int noticeCnt = noticeDao.selectNoticeCount();
	int lastPage = noticeCnt / rowPerPage;
	if(lastPage % rowPerPage != 0) {
		lastPage++;
	}
	
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지</title>
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
								<h4 class="mb-0">공지</h4>
							</div>
							<div class="col-6 text-end">
								<%
									if(loginMember.getMemberLevel() == 1) {
								%>
										<a href="<%=request.getContextPath() %>/admin/insertNoticeForm.jsp" class="btn bg-gradient-primary btn-lg">공지등록</a>
								<%
									} else {
								%>
										&nbsp;
								<%
									}
								%>
							</div>
						</div>
						<div class="card-body px-0 text-center">
							<table class="table align-items-center mb-3">
								<tr>
									<th style="width: 200px;">no</th>
									<th style="width: 1000px;">제목</th>
									<th>작성일자</th>
								</tr>
								<tr>
								<%
									for(Notice n : list) {
										String createdate = (String)(n.getCreatedate());
								%>
										<td><%=n.getNoticeNo() %></td>
										<td><a href="<%=request.getContextPath() %>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo() %>"><%=n.getNoticeTitle() %></a></td>
										<td><%=createdate.substring(0, 10) %></td>
										</tr>
								<%
									}
								%>
								<tr>
									<td colspan="4">
									<%
										if(currentPage != 0) {
									%>
											<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=1">처음</a>
									<%
										}
									
										if (currentPage > 1) {
									%>
											<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=<%=currentPage - 1 %>">이전</a>
									<%
										}
									
										if (currentPage < lastPage) {
									%>
											<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=<%=currentPage + 1 %>">다음</a>
									<%
										}
									
										if (lastPage != 0) {
									%>
											<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=<%=lastPage %>">마지막</a>
									<%
										}
									%>
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
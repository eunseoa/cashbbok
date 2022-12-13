<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	//로그인 정보 저장
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// 접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} 
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지당 보일 행의 수
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
										<a href="<%=request.getContextPath() %>/admin/notice/insertNoticeForm.jsp" class="btn bg-gradient-primary btn-lg">공지등록</a>
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
							</table>
							<div>
								<%
								if (currentPage != 0) {
								%>
										<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=1">&lt;&lt;&nbsp;</a>
								<%
									}
								
									if (currentPage > 1) {
								%>
										<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=<%=currentPage - 1 %>">&lt;&nbsp;</a>
								<%
									} else {
								%>
										<a class="disable">&lt;&nbsp;</a>
								<%
									}
								%>
										<%=currentPage %>
								<%
								
									if (currentPage < lastPage) {
								%>
										<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=<%=currentPage + 1 %>">&gt;&nbsp;</a>
								<%
									} else {
								%>
										<a class="disable">&gt;&nbsp;</a>
								<%
									}
								
									if (lastPage != 0) {
								%>
										<a href="<%=request.getContextPath() %>/notice/noticeList.jsp?currentPage=<%=lastPage %>">&gt;&gt;</a>
								<%
									}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
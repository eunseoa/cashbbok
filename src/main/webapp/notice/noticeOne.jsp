<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 비로그인, 일반회원 접근금지
	if(session.getAttribute("loginMember") == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	// 로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));

	// 공지 번호
	String noticeNo = request.getParameter("noticeNo");
	
	// Model
	NoticeDao noticeDao = new NoticeDao();
	Notice noticeOne = noticeDao.selectNoticeOne(noticeNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>NoticeOne</title>
		<link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">
		<link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			table {
				border-collapse: separate;
				border-spacing: 20px;
			}
			
			textarea {
				height: 600px;
				resize: none;
			}
			
			input {
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
				<div class="card" style="height: 920px;">
					<div class="card-header">
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<ul class="list-group">
								<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
									<div class="d-flex flex-column" style="width:1200px;">
										<table>
											<tr>
												<th>제목</th>
												<td><input type="text" class="form-control" value="<%=noticeOne.getNoticeTitle() %>" readonly="readonly"></td>
											</tr>
											<tr>
												<th>작성일자</th>
												<td><input type="text" class="form-control" value="마지막 수정일자 · <%=noticeOne.getUpdatedate() %> - 최초 작성일자 · <%=noticeOne.getCreatedate() %>" readonly="readonly"></td>
											</tr>
											<tr>
												<th>내용</th>
												<td><textarea class="form-control" cols="100" readonly="readonly"><%=noticeOne.getNoticeMemo() %></textarea></td>
											</tr>
										</table>
									</div>
									<div class="ms-auto text-end">
										<% 
											if(loginMember.getMemberLevel() == 1) {
										%>
											<a class="btn btn-link text-danger text-gradient px-3 mb-0" href="<%=request.getContextPath() %>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=noticeOne.getNoticeNo() %>">
												<i class="far fa-trash-alt"></i>
											</a>
											<a class="btn btn-link text-dark px-3 mb-0" href="<%=request.getContextPath() %>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=noticeOne.getNoticeNo() %>">
												<i class="fas fa-pencil-alt text-dark"></i>
											</a>
										<%
											}
										%>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
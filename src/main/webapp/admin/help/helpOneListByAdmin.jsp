<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	//접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} else if(loginMember.getMemberLevel() < 1) { // 일반회원일 경우
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 확인할 문의의 정보가 넘어오지않았을때
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")) {
		out.println("<script>alert('오류'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model 호출
	Help help = new Help();
	help.setHelpNo(helpNo);
	
	// 문의 상세정보 리스트
	HelpDao helpDao = new HelpDao();
	Help helpOne = helpDao.selectHelpOne(helpNo);
	
	// 문의 답변 리스트
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> commentList = commentDao.selectCommentList(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="shortcut icon" type="image/x-icon" href="../../assets/img/favicon.ico">
		<link href="../../assets/css/nucleo-icons.css" rel="stylesheet" />
		<script src="https://kit.fontawesome.com/42d5adcbca.js"></script>
		<link id="pagestyle" href="../../assets/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
		<style>
			table {
				border-collapse: separate;
				border-spacing: 20px;
			}
			
			textarea {
				height: 235px;
				resize: none;
			}
			
			input {
				height: 60px;
			}
			
		</style>
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByAdmin.jsp"></jsp:include>
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
				<div class="row">
					<div class="col-12">
						<div class="card mb-4" style="height: 600px;">
							<div class="card-header">
								<div class="card-body px-0 pt-0 pb-0 text-center">
									<ul class="list-group">
										<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
											<div class="d-flex flex-column" style="width:1400px;">
												<table>
													<tr>
														<th>제목</th>
														<td><input type="text" class="form-control" value="<%=helpOne.getHelpTitle() %>" readonly="readonly"></td>
													</tr>
													<tr>
														<th>작성자</th>
														<td>
														<%
															if (helpOne.getMemberId() == null) {
														%>
																<input type="text" class="form-control" value="탈퇴한 회원" readonly="readonly">
														<%
															} else {
														%>
																<input type="text" class="form-control" value="<%=helpOne.getMemberId() %>" readonly="readonly">
														<%
															}
														%>
														</td>
													</tr>
													<tr>
														<th>내용</th>
														<td><textarea class="form-control" cols="100" readonly="readonly"><%=helpOne.getHelpMemo() %></textarea></td>
													</tr>
													<tr>
														<th></th>
														<td><span class="mb-2 text-sm">마지막 수정 · <%=helpOne.getUpdatedate() %> &nbsp; 최초 작성 · <%=helpOne.getCreatedate() %></span></td>
													</tr>
												</table>
											</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header pb-0 px-3">
								<div class="row">
									<div class="col-6 d-flex align-items-center">
										<h4 class="mb-0">답변</h4>
									</div>
									<div class="col-6 text-end">
										<a href="<%=request.getContextPath() %>/admin/comment/insertCommentForm.jsp" class="btn bg-gradient-primary btn-sm">추가</a><!-- modal..? -->
									</div>
								</div>
							</div>
							<div class="card-body pt-4 p-3">
								<ul class="list-group">
									<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
										<div class="d-flex flex-column" style="width:1250px;">
											<table>
											<%
												for(HashMap<String, Object> c : commentList) {
													System.out.println((c.get("commentMemo")));
											%>
													<tr>
											<%
													if(c.get("commentMemo") == null) {
											%>
														<td><span>답변 대기</span></td>
											<%
													} else {
											%>
														<td><%=c.get("commentMemo") %></td>
														<td><%=c.get("memberId") %></td>
														<td><%=c.get("createdate") %></td>
											<%
													}
											%>
													</tr>
											<%
												}
											%>
											</table>
										</div>
										<div class="ms-auto text-end">
										<%
											for(HashMap<String, Object> c : commentList) {
												System.out.println((c.get("commentMemo")));
										%>
												<a class="btn btn-link text-danger text-gradient px-3 mb-0" href="<%=request.getContextPath() %>/admin/comment/deleteComment.jsp?helpNo=<%=helpNo %>&commentNo=<%=c.get("commentNo") %>">
													<i class="far fa-trash-alt"></i>
												</a>
												<a class="btn btn-link text-dark px-3 mb-0" href="<%=request.getContextPath() %>/admin/comment/updateCommentForm.jsp?helpNo=<%=helpNo %>&commentNo=<%=c.get("commentNo") %>">
													<i class="fas fa-pencil-alt text-dark"></i>
												</a>
												<!-- 수정 삭제 비동기식으로 바꿀예정 -->
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
			</div>
		</main>
	</body>
</html>
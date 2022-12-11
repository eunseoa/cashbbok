<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo);
	String memberId = loginMember.getMemberId();
	
	// Model 호출
	// 문의 내용
	HelpDao helpDao = new HelpDao();
	Help help = helpDao.selectHelpOne(helpNo);
	
	// 댓글있으면 수정/삭제 출력안함
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(memberId);
	
	// 댓글 출력
	CommentDao commentDao = new CommentDao();
	ArrayList<HashMap<String, Object>> commentList = commentDao.selectCommentList(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HelpOne</title>
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
		<jsp:include page="/inc/sidebarByMember.jsp"></jsp:include>
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
											<div class="d-flex flex-column" style="width:1250px;">
												<table>
													<tr>
														<th>제목</th>
														<td><input type="text" class="form-control" value="<%=help.getHelpTitle() %>" readonly="readonly"></td>
													</tr>
													<tr>
														<th>작성자</th>
														<td><input type="text" class="form-control" value="<%=help.getMemberId() %>" readonly="readonly"></td>
													</tr>
													<tr>
														<th>내용</th>
														<td><textarea class="form-control" cols="100" readonly="readonly"><%=help.getHelpMemo() %></textarea></td>
													</tr>
													<tr>
														<th></th>
														<td><span class="mb-2 text-sm">마지막 수정 · <%=help.getUpdatedate() %> &nbsp; 최초 작성 · <%=help.getCreatedate()%></span></td>
													</tr>
												</table>
											</div>
											<div class="ms-auto text-end">
												<%
													for(HashMap<String, Object> m : helpList) {
														if(m.get("commentCreatedate") == null && (Integer)m.get("helpNo") == helpNo) {
												%>
															<a class="btn btn-link text-danger text-gradient px-3 mb-0" href="<%=request.getContextPath() %>/member/help/deleteHelp.jsp?helpNo=<%=helpNo %>">
																<i class="far fa-trash-alt"></i>
															</a>
															<a class="btn btn-link text-dark px-3 mb-0" href="<%=request.getContextPath() %>/member/help/updateHelpForm.jsp?helpNo=<%=helpNo %>">
																<i class="fas fa-pencil-alt text-dark"></i>
															</a>
												<%
														}
								
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
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header pb-0 px-3">
								<div class="row">
									<h6 class="mb-0">답변</h6>
								</div>	
							</div>
							<div class="card-body pt-4 p-3">
								<ul class="list-group">
									<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
										<div class="d-flex flex-column" style="width:1250px;">
											<%
												for(HashMap<String, Object> c : commentList) {
												   System.out.println((c.get("commentMemo")));
												   if(c.get("commentMemo") != null || c.get("commentMemo").equals("")) {
											%>
														<h6 class="mb-3 text-sm"><%=c.get("memberId") %></h6>
														<span class="text-dark font-weight-bold ms-sm-2"><%=c.get("commentMemo") %></span><br>
														<span class="mb-2 text-sm"><%=c.get("createdate") %></span>
											<%
												   } else {
											%>
														<h6 class="mb-3 text-sm">답변이 달리기 전입니다</h6>
											<%
												   }
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	//로그인 정보 저장
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	
	//접근금지
	if(loginMember == null) { // 비로그인시
		out.println("<script>alert('로그인이 필요합니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	} else if(loginMember.getMemberLevel() == 1) { // 관리자가 임의로 고객 문의 수정 방지
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String memberId = loginMember.getMemberId();
	
	// 내용 미입력시 경고창 출력
	String msg = request.getParameter("msg");
	
	// Model 호출
	Help help = new Help();
	HelpDao helpDao = new HelpDao();
	
	// 업데이트할 정보 출력
	Help helpOne = helpDao.selectUpdateHelp(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>UpdateHelp</title>
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
				height: 430px;
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
				<div class="card" style="height: 920px;">
					<div class="card-header">
						<div class="card-body px-0 pt-0 pb-0 text-center">
							<ul class="list-group">
								<li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
									<form action="<%=request.getContextPath() %>/member/help/updateHelpAction.jsp" method="post">
										<div class="d-flex flex-column" style="width:1450px;">
											<table>
												<tr>
													<td colspan="2">
													<%
														if(msg != null) {
													%>
															<%=msg %>
													<%
														} else {
													%>
															&nbsp;
													<%
														}
													%>
													</td>
												</tr>
												<tr>
													<td><input type="hidden" name="helpNo" value="<%=helpOne.getHelpNo() %>" readonly="readonly"></td>
												</tr>
												<tr>
													<td>제목</td>
													<td><input type="text" name="helpTitle" value="<%=helpOne.getHelpTitle() %>" class="form-control"></td>
												</tr>
												<tr>
													<td>내용</td>
													<td><textarea name="helpMemo" class="form-control"><%=helpOne.getHelpMemo() %></textarea></td>
												</tr>
												<tr>
													<td>등록일자</td>
													<td><input type="text" name="createdate" value="<%=helpOne.getCreatedate() %>" readonly="readonly" class="form-control"></td>
												</tr>
												<tr>
													<td>회원</td>
													<td><input type="text" name="memberId" value="<%=helpOne.getMemberId() %>" class="form-control"></td>
												</tr>
											</table>
										</div>
										<div>
											<button type="submit" class="btn btn-primary btn-lg w-100">수정</button>
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
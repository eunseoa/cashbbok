<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 비로그인, 일반회원 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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
				font-size: 15px;
			}
		</style>
	</head>
	<body class="g-sidenav-show bg-gray-100">
		<div class="min-height-300 bg-primary position-absolute w-100"></div>
		<jsp:include page="/inc/sidebarByMember.jsp"></jsp:include>
		<main class="main-content border-radius-lg">
			<div class="container-fluid py-4">
				<div class="card" style="height: 950px;">
					<div class="card-header pb-0">
						<div class="pb-4">
							<h4>공지 등록</h4>
						</div>
						<div class="card-body px-0 pt-0 pb-0">
							<form action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp" method="post">
								<table>
									<tr>
										<th>제목</th>
										<td><input class="form-control"  type="text" name="noticeTitle"></td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea class="form-control" cols="200" name="noticeMemo"></textarea></td>
									</tr>
									<tr>
										<td colspan="2" style="text-align:right;">
											<button type="submit" class="btn btn-primary">add</button>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>
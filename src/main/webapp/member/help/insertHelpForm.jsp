<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	} else if(loginMember.getMemberLevel() == 1) { // 관리자 접근 금지
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	// 내용 미입력시 경고창 출력
	String msg = request.getParameter("msg");
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
							<h4>문의 등록</h4>
						</div>
						<div class="card-body px-0 pt-0 pb-0">
							<form action="<%=request.getContextPath() %>/member/help/insertHelpAction.jsp" method="post">
								<table>
									<tr>
										<td><input type="hidden" name="memberId" value="<%=loginMember.getMemberId() %>"></td>
									</tr>
									<tr>
										<th>제목</th>
										<td><input class="form-control"  type="text" name="helpTitle"></td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea class="form-control" cols="200" name="helpMemo"></textarea></td>
									</tr>
									<tr>
										<td></td>
										<td>
											<button type="submit" class="btn bg-gradient-primary btn-lg w-100">add</button>
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
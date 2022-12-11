<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 삭제할 댓글의 정봅가 넘어오지않았을때
	if(request.getParameter("helpNo") == null || request.getParameter("helpNo").equals("")
		|| request.getParameter("commentNo") == null || request.getParameter("commentNo").equals("")) { //
		out.println("<script>alert('접근할 수 없습니다'); location.href='" + request.getContextPath() + "/log/loginForm.jsp" + "';</script>");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteComment(commentNo);
	
	if(row == 1) {
		System.out.println("댓글 삭제 성공");
		out.println("<script>alert('댓글을 삭제했습니다'); location.href='" + request.getContextPath() + "/admin//help/helpOneListByAdmin.jsp?helpNo=" + helpNo + "';</script>");
		return;
	} else {
		System.out.println("삭제실패");
		out.println("<script>alert('댓글삭제에 실패했습니다'); location.href='" + request.getContextPath() + "/admin//help/helpOneListByAdmin.jsp?helpNo=" + helpNo + "';</script>");
		return;
	}
%>
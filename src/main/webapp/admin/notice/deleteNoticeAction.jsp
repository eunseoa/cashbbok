<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 삭제할 공지의 정보가 넘어오지않았을때
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")) { // 비로그인시
		out.println("<script>alert('오류'); location.href='" + request.getContextPath() + "/admin/notice/noticeOne.jsp" + "';</script>");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// Model
	NoticeDao noticeDao = new NoticeDao();
	
	// 공지 삭제 메소드
	int row = noticeDao.deleteNotice(noticeNo);
	
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
		return;
	} else {
		System.out.println("삭제실패");
		out.println("<script>alert('삭제에 실패했습니다'); location.href='" + request.getContextPath() + "/admin/notice/noticeOne.jsp?noticeNo=" + noticeNo + "';</script>");
		return;
	}
%>
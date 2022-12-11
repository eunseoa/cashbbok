<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// Model
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.deleteNotice(noticeNo);
	
	if(row == 1) {
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeList.jsp");
		return;
	} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/admin/notice/noticeOne.jsp?noticeNo=" + noticeNo);
		return;
	}
%>
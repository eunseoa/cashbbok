<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비로그인, 일반회원 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/log/loginForm.jsp");
		return;
	}
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeMemo = request.getParameter("noticeMemo");
	
	// Model 호출
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	notice.setNoticeTitle(noticeTitle);
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	if(row == 1) {
		System.out.println("등록성공");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return;
	} else {
		System.out.println("등록실패");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return;
	}
%>
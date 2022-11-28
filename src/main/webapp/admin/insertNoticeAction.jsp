<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 비로그인 접근금지
	Member loginMember = (Member)(session.getAttribute("loginMember"));
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String noticeMemo = request.getParameter("noticeMemo");
	
	// Model 호출
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.insertNotice(notice);
	
	if(row == 1) {
		System.out.println("등록성공");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	} else {
		System.out.println("등록실패");
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}
%>
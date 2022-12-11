<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	// 내용 미입력시
	if(request.getParameter("noticeTitle") == null || request.getParameter("noticeTitle").equals("")
		|| request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")) {
		String msg = URLEncoder.encode("입력되지않은 항목이 있습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp?msg=" + msg);
		return;
	}
	
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeMemo = request.getParameter("noticeMemo");
	
	// Model 호출
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	notice.setNoticeTitle(noticeTitle);
	
	NoticeDao noticeDao = new NoticeDao();
	
	// 공지 등록 메소드
	int row = noticeDao.insertNotice(notice);
	
	if(row == 1) {
		System.out.println("등록성공");
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return;
	} else {
		System.out.println("등록실패");
		out.println("<script>alert('공지등록에 실패했습니다'); location.href='" + request.getContextPath() + "/notice/noticeList.jsp" + "';</script>");
		return;
	}
%>
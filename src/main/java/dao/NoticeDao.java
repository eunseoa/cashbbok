package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// 공지 등록
	public int insertNotice(Notice notice) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 공지 수정
	public int updateNotice(Notice notice) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		stmt.setInt(2, notice.getNoticeNo());
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return 0;
	}
	
	// 공지 삭제
	public int deleteNotice(Notice notice) throws Exception {
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		return 0;
	}
	
	// 마지막 페이지 구함
	public int selectNoticeCount() throws Exception {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 데이터 전체 갯수
		String sql = "SELECT COUNT(*) count FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			count = Integer.parseInt(rs.getString("count"));
		}
		return count;
	}
	
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 공지 출력
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
	
}

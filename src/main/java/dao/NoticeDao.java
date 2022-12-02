package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// 관리자
	// 공지 등록
	public int insertNotice(Notice notice) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			row = stmt.executeUpdate();
			if(row == 1) {
				resultRow = 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return resultRow;
	}
	
	// 공지 수정
	public int updateNotice(Notice notice) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
			row = stmt.executeUpdate();
			if(row == 1) {
				resultRow = 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		return resultRow;
	}
	
	// 공지 삭제
	public int deleteNotice(int noticeNo) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			row = stmt.executeUpdate();
			if(row == 1) {
				resultRow = 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 마지막 페이지 구함
	public int selectNoticeCount() {
		// 초기화
		int count = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 데이터 전체 갯수
		String sql = "SELECT COUNT(*) count FROM notice";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				count = Integer.parseInt(rs.getString("count"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return count;
	}
	
	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		// 초기화
		ArrayList<Notice> list = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 공지 출력
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice ORDER BY createdate DESC LIMIT ?, ?";
		
		// 예외출력
		try {
			list = new ArrayList<Notice>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
}

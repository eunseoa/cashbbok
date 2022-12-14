package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Help;

public class HelpDao {
	// 로그인한 회원이 작성한 문의만
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = null;
		// db연결 메소드 
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.member_id memberId, h.createdate helpCreatedate, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ?";
		
		// 예외처리
		try {
			list = new ArrayList<HashMap<String, Object>>();
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpTitle", rs.getString("helpTitle"));
				m.put("memberId", rs.getString("memberId"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
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
		
		return list;
	}
	
	// helpOneList 문의 상세보기
	public Help selectHelpOne(int helpNo) {
		// 초기화
		Help resultHelp = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT help_title helpTitle, help_memo helpMemo, member_id memberId, updatedate, createdate FROM help WHERE help_no = ?";
		
		// 예외처리
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultHelp = new Help();
				resultHelp.setHelpTitle(rs.getString("helpTitle"));
				resultHelp.setHelpMemo(rs.getString("helpMemo"));
				resultHelp.setMemberId(rs.getString("memberId"));
				resultHelp.setUpdatedate(rs.getString("updatedate"));
				resultHelp.setCreatedate(rs.getString("createdate"));
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
		
		return resultHelp;
	}
	
	// 문의 등록
	public int insertHelp(Help help) {
		// 초기화
		int resultRow = 0;
		// db 메소드 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "INSERT INTO help(help_memo, help_title, member_id, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";

		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getHelpTitle());
			stmt.setString(3, help.getMemberId());
			
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
	
	// 문의 수정
	// 수정 form에 출력
	public Help selectUpdateHelp(int helpNo) {
		// 초기화
		Help resultRow = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT help_no helpNo, help_title helpTitle, help_memo helpMemo, member_id memberId, createdate FROM help WHERE help_no = ?";
		
		// 예외처리
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultRow = new Help();
				resultRow.setHelpNo(rs.getInt("helpNo"));
				resultRow.setHelpTitle(rs.getString("helpTitle"));
				resultRow.setHelpMemo(rs.getString("helpMemo"));
				resultRow.setMemberId(rs.getString("memberId"));
				resultRow.setCreatedate(rs.getString("createdate"));
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
		
		return resultRow;
	}
	
	// 수정 메소드
	public int updateHelp(Help help) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "UPDATE help SET help_title = ?, help_memo = ?, updatedate = NOW() WHERE help_no = ? AND member_id = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpTitle());
			stmt.setString(2, help.getHelpMemo());
			stmt.setInt(3, help.getHelpNo());
			stmt.setString(4, help.getMemberId());
			
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
	
	// 문의 삭제
	public int deleteHelp(String memberId, int helpNo) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "DELETE FROM help WHERE member_id = ? AND help_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, helpNo);
			
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
	
	// 관리자
	// selectHelpList 오버로딩
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.member_id memberId, h.createdate helpCreatedate, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no LIMIT ?, ?";
		
		// 예외처리
		try {
			list = new ArrayList<HashMap<String, Object>>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpTitle", rs.getString("helpTitle"));
				m.put("memberId", rs.getString("memberId"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
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
		
		return list;
	}
	
}
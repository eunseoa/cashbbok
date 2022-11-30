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
	public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.member_id memberId, h.createdate helpCreatedate, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no WHERE h.member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
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
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	// helpOneList 문의 상세보기
	public Help selectHelpOne(int helpNo) throws Exception {
		Help resultHelp = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT help_title helpTitle, help_memo helpMemo, member_id memberId, updatedate, createdate FROM help WHERE help_no = ?";
			
		DBUtil dbUtil = new DBUtil();
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
			
		dbUtil.close(rs, stmt, conn);
		
		return resultHelp;
	}
	
	// 문의 등록
	public int insertHelp(Help help) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO help(help_memo, member_id, updatedate, createdate) VALUES(?, ?, NOW(), NOW())";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpMemo());
		stmt.setString(2, help.getMemberId());
		
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 문의 수정
	// 수정 form에 출력
	public Help selectUpdateHelp(int helpNo) throws Exception {
		Help resultRow = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT help_no helpNo, help_title helpTitle, help_memo helpMemo, member_id memberId, createdate FROM help WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
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
		
		dbUtil.close(rs, stmt, conn);
		
		return resultRow;
	}
	
	// 수정 메소드
	public int updateHelp(Help help) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE help SET help_title = ?, help_memo = ?, updatedate = NOW() WHERE help_no = ? AND member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, help.getHelpTitle());
		stmt.setString(2, help.getHelpMemo());
		stmt.setInt(3, help.getHelpNo());
		stmt.setString(4, help.getMemberId());
		
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 문의 삭제
	public int deleteHelp(String memberId, int helpNo) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM help WHERE member_id = ? AND help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, helpNo);
		
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 관리자
	// selectHelpList 오버로딩
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT h.help_no helpNo, h.help_title helpTitle, h.member_id memberId, h.createdate helpCreatedate, c.createdate commentCreatedate FROM help h LEFT OUTER JOIN comment c ON h.help_no = c.help_no LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
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
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
}
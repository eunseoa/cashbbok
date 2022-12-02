package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	// 관리자
	// 답변출력
	public ArrayList<HashMap<String, Object>> selectCommentList(int helpNo) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT comment_no commentNo, comment_memo commentMemo, member_id memberId, createdate FROM comment WHERE help_no = ?";
		
		// 예외처리
		try {
			list = new ArrayList<HashMap<String, Object>>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("commentNo", rs.getInt("commentNo"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("memberId", rs.getString("memberId"));
				m.put("createdate", rs.getString("createdate"));
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

		
	
	// 답변 추가
	public int insertComment(Comment comment) {
		// 초기화 
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "INSERT INTO comment(help_no helpNo, comment_memo commentMemo, member_id memberId, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			
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
	
	// 답변 수정
	// 수정 form 출력
	public Comment selectCommentOne(int commentNo) {
		// 초기화
		Comment resultSet = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT comment_memo commentMemo, member_id memberId FROM comment WHERE comment_no = ?";
		
		// 에외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultSet = new Comment();
				resultSet.setCommentMemo(rs.getString("commentMemo"));
				resultSet.setMemberId(rs.getString("memberId"));
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
		
		return resultSet;
	}
	
	// 수정메소드
	public int updateComment(Comment comment) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no = ? AND member_id = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
			stmt.setString(3, comment.getMemberId());
			
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
	
	// 답변 삭제
	public int deleteComment(int commentNo) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "DELETE from comment WHERE comment_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			
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
}

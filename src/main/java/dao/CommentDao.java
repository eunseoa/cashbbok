package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	// 답변출력
	public ArrayList<HashMap<String, Object>> selectCommentList(int helpNo) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT comment_no commentNo, comment_memo commentMemo, member_id memberId, createdate FROM comment WHERE help_no = ?";
		
		DBUtil dbUtil = new DBUtil();
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
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	// 답변 추가
	public int insertComment(Comment comment) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO comment(help_no helpNo, comment_memo commentMemo, member_id memberId, updatedate, createdate) VALUES(?, ?, ?, NOW(), NOW())";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 답변 수정
	// 수정 form 출력
	public Comment selectCommentOne(int commentNo) throws Exception {
		Comment resultSet = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT comment_memo commentMemo, member_id memberId FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			resultSet = new Comment();
			resultSet.setCommentMemo(rs.getString("commentMemo"));
			resultSet.setMemberId(rs.getString("memberId"));
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return resultSet;
	}
	
	// 수정메소드
	public int updateComment(Comment comment) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE comment SET comment_memo = ? WHERE comment_no = ? AND member_id = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, comment.getCommentMemo());
		stmt.setInt(2, comment.getCommentNo());
		stmt.setString(3, comment.getMemberId());
		
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		return row;
	}
	
	// 답변 삭제
	public int deleteComment(int commentNo) throws Exception {
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "DELETE from comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		return row;	
	}
}

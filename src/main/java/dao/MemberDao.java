package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		// db연결하는 메소드
		DBUtil  dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		// 로그인 쿼리
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}

		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;

	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		int resultRow = 0;
		return resultRow;
	}
	
	// 회원정보 수정
	public Member updateMember(Member member) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member SET member_name = ? WHERE member_id = ? AND member_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberName());
		stmt.setString(2, member.getMemberId());
		stmt.setString(3, member.getMemberPw());
		int row = stmt.executeUpdate();
		if(row == 1) {
			resultMember = new Member();
			resultMember.getMemberName();
		}
		return resultMember;
	}
}

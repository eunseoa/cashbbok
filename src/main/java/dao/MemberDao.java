package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	
	// 회원가입
	// 1) id 중복확인 / 반환값 t: 아이디 중복 f: 아이디 사용가능
	public boolean selectMemberIdCk(String memberId) throws Exception {
		boolean result = false;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 중복확인 쿼리
		String sql = "SELECT member_id FROM member WHERE  member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			result = true;
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return result;
	}
	
	// 2) 회원가입
	public int insertMember(Member member) throws Exception {
		int row = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 회원가입 쿼리
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		// db연결하는 메소드
		DBUtil  dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 로그인 쿼리
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return resultMember;
	}
	
	
	// 회원정보 수정
	public Member updateMember(Member paramMember) throws Exception {
		Member resultMember = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 정보수정 쿼리
		String sql = "UPDATE member SET member_name = ? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, paramMember.getMemberId());
		stmt.setString(3, paramMember.getMemberPw());
		int row = stmt.executeUpdate();
		if(row == 1) {
			resultMember = login(paramMember);
			
		}
		
		return resultMember;
	}
	
	// 회원정보 삭제
	public int deleteMember(Member member) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 정보 삭제 쿼리
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		row = stmt.executeUpdate();
		if(row == 1) {
			row = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
	
	// 관리자 기능
	// 관리자 memberList
	public ArrayList<Member> selectMemberByPage(int beginRow, int rowPerPage) throws Exception {
		// order by createdate desc;
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setMemberName(rs.getString("memberName"));
			m.setUpdatedate(rs.getString("updatedate"));
			m.setCreatedate(rs.getString("createdate"));
			list.add(m);
		}
		
		return list;
	}
	
	// 관리자가 멤버 강퇴
	public int deleteMemberByAdmin(Member member) throws Exception {
		int deleteRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM member WHERE member_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberNo());
		deleteRow = stmt.executeUpdate();
		if (deleteRow == 1) {
			deleteRow = 1;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return deleteRow;
	}
	
	// 멤버수
	public int selectMembetCount() throws Exception {
		return 0;
	}
	
	// 관리자가 멤버 레벨 수정 
	public int updateMemberLevel(Member member) throws Exception {
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE member SET member_level = ? WHERE member_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, member.getMemberLevel());
		stmt.setInt(2, member.getMemberNo());
		resultRow = stmt.executeUpdate();
		
		return resultRow;
	}
}

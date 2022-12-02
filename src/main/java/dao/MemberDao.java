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
	public boolean selectMemberIdCk(String memberId) {
		// 초기화
		boolean result = false;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// 중복확인 쿼리
		String sql = "SELECT member_id FROM member WHERE  member_id = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = true;
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

		return result;
	}
	
	// 2) 회원가입
	public int insertMember(Member member) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		// 회원가입 쿼리
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES (?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			stmt.setString(3, member.getMemberName());
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
	
	// 로그인
	public Member login(Member paramMember) {
		// 초기화
		Member resultMember = null;
		// db 연결 메소드
		DBUtil  dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				resultMember.setMemberName(rs.getString("memberName"));
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

		return resultMember;
	}
	
	
	// 회원정보 수정
	public Member updateMember(Member paramMember) {
		// 초기화
		Member resultMember = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "UPDATE member SET member_name = ? WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberName());
			stmt.setString(2, paramMember.getMemberId());
			stmt.setString(3, paramMember.getMemberPw());
			row = stmt.executeUpdate();
			if(row == 1) {
				resultMember = login(paramMember);
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
		
		return resultMember;
	}
	
	// 회원정보 삭제
	public int deleteMember(Member member) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
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
	
	// 관리자 기능
	// 관리자 memberList
	public ArrayList<Member> selectMemberByPage(int beginRow, int rowPerPage) {
		// order by createdate desc;
		// 초기화
		ArrayList<Member> list = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC";
		
		// 예외처리
		try {
			list = new ArrayList<Member>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
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
	
	// 관리자가 멤버 강퇴
	public int deleteMemberByAdmin(Member member) {
		// 초기화
		int deleteRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "DELETE FROM member WHERE member_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberNo());
			row = stmt.executeUpdate();
			if (row == 1) {
				deleteRow = 1;
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
		
		return deleteRow;
	}
	
	// 멤버수
	public int selectMembetCount() {
		// 초기화
		int count = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) cnt FROM member";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
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

	// 관리자가 멤버 레벨 수정 
	public int updateMemberLevel(Member member) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		String sql = "UPDATE member SET member_level = ? WHERE member_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
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

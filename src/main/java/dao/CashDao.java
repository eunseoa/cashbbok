package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Cash;

public class CashDao {
	
	// cashDateList.jsp에서 호출됨
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		
		// 예외처리
		try {
			list = new ArrayList<HashMap<String, Object>>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2,  year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryNo", rs.getInt("categoryNo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
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
	
	// cashList.jsp에서 호출됨
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		
		// 예외처리
		try {
			list = new ArrayList<HashMap<String, Object>>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
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
	
	// cashDateList.jsp에서 호출됨
	public int insertCash(Cash cash) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		// 소비, 지출내역 추가 
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getMemberId());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
			
			row = stmt.executeUpdate();
		
			if (row == 1) {
				resultRow = 1;
			} else {
				resultRow = 0;
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
	
	// updateForm에서 출력
	public Cash selectUpdateCashOne(Cash cash) {
		// 초기화
		Cash resultCash = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_price cashPrice, cash_memo cashMemo FROM cash WHERE member_id = ? AND cash_no = ?";

		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1,cash.getMemberId());
			stmt.setInt(2,cash.getCashNo());
			rs = stmt.executeQuery();
			if(rs.next()){
				resultCash = new Cash();
				resultCash.setCashNo(rs.getInt("cashNo"));
				resultCash.setCategoryNo(rs.getInt("categoryNo"));
				resultCash.setCashPrice(rs.getLong("cashPrice"));
				resultCash.setCashMemo(rs.getString("cashMemo"));
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
		return resultCash;
	}

	// 지출, 수입 내역 수정
	public int updateCash(Cash cash) {
		// 초기화
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		// cash 내역 수정
		String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE member_id = ? AND cash_no = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setLong(2, cash.getCashPrice());
			stmt.setString(3, cash.getCashMemo());
			stmt.setString(4, cash.getMemberId());
			stmt.setInt(5, cash.getCashNo());
			row = stmt.executeUpdate();
			if(row == 1) {
				resultRow = 1;
			} else {
				resultRow = 0;
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
		
	// 지출, 수입 내역 삭제
	public int deleteCash(Cash cash) {
		// 초기화
		int deleteRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		int row = 0;
		// cash 내역 삭제
		String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
		
		// 예외처리
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCashNo());
			stmt.setString(2, cash.getMemberId());
			row = stmt.executeUpdate();
			if(row == 1) {
				deleteRow = 1;
			} else {
				deleteRow = 0;
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
	
	// 통계데이터
	// 년도별 수입, 지출 리스트
	public ArrayList<HashMap<String, Object>> selectCashYearList(String memberId) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT YEAR(t2.cashDate) year"
					+ "		, IFNULL(FORMAT(SUM(t2.importCash), 0), 0) importCashSum "
					+ "		, IFNULL(FORMAT(ROUND(AVG(t2.importCash)), 0), 0) importCashAvg"
					+ "		, IFNULL(FORMAT(SUM(t2.exportCash), 0), 0) exportCashSum"
					+ "		, IFNULL(FORMAT(ROUND(AVG(t2.exportCash)), 0), 0) exportCashAvg "
					+ "FROM "
					+ "	(SELECT memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, NULL) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, NULL) exportCash "
					+ "	FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId "
					+ "			FROM cash cs "
					+ "				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2 "
					+ "WHERE t2.memberId = ? "
					+ "GROUP BY YEAR(t2.cashDate) "
					+ "ORDER BY YEAR(t2.cashDate) ASC";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("year"));
				m.put("importCashSum", rs.getString("importCashSum"));
				m.put("importCashAvg", rs.getString("importCashAvg"));
				m.put("exportCashSum", rs.getString("exportCashSum"));
				m.put("exportCashAvg", rs.getString("exportCashAvg"));
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
	
	// 현재 년도를 받아서 월별 수입, 지출 합계 리스트 출력
	public ArrayList<HashMap<String, Object>> selectCashSumAvgByMonthList(int year, String memberId) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT MONTH(t2.cashDate) month"
					+ "		, IFNULL(FORMAT(SUM(t2.importCash), 0), 0) importCashSum"
					+ "		, IFNULL(FORMAT(ROUND(AVG(t2.importCash)), 0), 0) importCashAvg"
					+ "		, IFNULL(FORMAT(SUM(t2.exportCash), 0), 0) exportCashSum"
					+ "		, IFNULL(FORMAT(ROUND(AVG(t2.exportCash)), 0), 0) exportCashAvg "
					+ "FROM "
					+ "	(SELECT memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, NULL) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ "	FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId "
					+ "			FROM cash cs "
					+ "				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2 "
					+ "WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? "
					+ "GROUP BY MONTH(t2.cashDate) "
					+ "ORDER BY MONTH(t2.cashDate) ASC";

		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("importCashSum", rs.getString("importCashSum"));
				m.put("importCashAvg", rs.getString("importCashAvg"));
				m.put("exportCashSum", rs.getString("exportCashSum"));
				m.put("exportCashAvg", rs.getString("exportCashAvg"));
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
	
	// 월별 통계 cashList에서 출력
	public HashMap<String, Object> cashListByMonth(int year, int month, String memberId) {
		// 초기화
		HashMap<String, Object> cash = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT MONTH(t2.cashDate) month "
					+ "		, IFNULL(FORMAT(SUM(t2.importCash), 0), 0) importCash "
					+ "		, IFNULL(FORMAT(SUM(t2.exportCash), 0), 0) exportCash "
					+ "FROM "
					+ "	(SELECT memberId "
					+ "			, cashNo "
					+ "			, cashDate "
					+ "			, IF(categoryKind = '수입', cashPrice, NULL) importCash "
					+ "			, IF(categoryKind = '지출', cashPrice, NULL) exportCash "
					+ "	FROM (SELECT cs.cash_no cashNo "
					+ "					, cs.cash_date cashDate "
					+ "					, cs.cash_price cashPrice "
					+ "					, cg.category_kind categoryKind "
					+ "					, cs.member_id memberId "
					+ "			FROM cash cs "
					+ "				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2 "
					+ "WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? AND MONTH(t2.cashDate) = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				cash =  new HashMap<String, Object>();
				cash.put("month", rs.getInt("month"));
				cash.put("importCash", rs.getString("importCash"));
				cash.put("exportCash", rs.getString("exportCash"));
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
		
		return cash;
	}
	
	// 현재년도를 받아서 차트에 출력(int타입으로 받아야하기때문에 format 사용할 수 없음)
	public ArrayList<HashMap<String, Object>> selectCashSumAvgByMonthIntList(int year, String memberId) {
		// 초기화
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT IFNULL(SUM(t2.importCash), 0) importCashSum"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) importCashAvg"
					+ "		, IFNULL(SUM(t2.exportCash), 0) exportCashSum"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) exportCashAvg "
					+ "FROM "
					+ "	(SELECT memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, NULL) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, NULL) exportCash"
					+ "	FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId "
					+ "			FROM cash cs "
					+ "				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2 "
					+ "WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ? "
					+ "GROUP BY MONTH(t2.cashDate) "
					+ "ORDER BY MONTH(t2.cashDate) ASC";

		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("importCashSum", rs.getInt("importCashSum"));
				m.put("importCashAvg", rs.getInt("importCashAvg"));
				m.put("exportCashSum", rs.getInt("exportCashSum"));
				m.put("exportCashAvg", rs.getInt("exportCashAvg"));
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
}
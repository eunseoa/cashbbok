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
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, c.cash_memo cashMemo, ct.category_no categoryNo, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2,  year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
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
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	// cashList.jsp에서 호출됨
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate, c.cash_price cashPrice, ct.category_kind categoryKind, ct.category_name categoryName FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2,  year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return list;
	}
	
	// cashDateList.jsp에서 호출됨
	public int insertCash(Cash cash) throws Exception {
		int resultRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// 소비, 지출내역 추가 
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) VALUES (?, ?, ?, ?, ?, CURDATE(), CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
			
		int row = stmt.executeUpdate();
	
		if (row == 1) {
			resultRow = 1;
		} else {
			resultRow = 0;
		}
		
		dbUtil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	// updateForm에서 출력
	public Cash selectUpdateCashOne(Cash cash) throws Exception {
		Cash resultCash = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT cash_no cashNo, category_no categoryNo, cash_price cashPrice, cash_memo cashMemo FROM cash WHERE member_id = ? AND cash_no = ?";
	
		DBUtil dbUtil = new DBUtil();
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
	
		dbUtil.close(rs, stmt, conn);
		
		return resultCash;
	}

	// update
	public int updateCash(Cash cash) throws Exception {
		int row = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// cash 내역 수정
		String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE member_id = ? AND cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setLong(2, cash.getCashPrice());
		stmt.setString(3, cash.getCashMemo());
		stmt.setString(4, cash.getMemberId());
		stmt.setInt(5, cash.getCashNo());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return row;
	}
		
	// delete
	public int deleteCash(Cash cash) throws Exception {
		int deleteRow = 0;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// cash 내역 삭제
		String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCashNo());
		stmt.setString(2, cash.getMemberId());
		deleteRow = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		
		return deleteRow;
	}
		
}
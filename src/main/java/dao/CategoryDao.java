package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;


public class CategoryDao {
	// cash 입력시 <select>목록 출력
	public ArrayList<Category> selectCategoryList() {
		// 초기화
		ArrayList<Category> categoryList = null;
		// db 연결 메소드
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_no ASC";
		
		// 예외처리
		try {
			categoryList = new ArrayList<Category>();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				categoryList.add(c);
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

		return categoryList;
	}
	
	// 관리자
	// admin -> 카테고리관리 -> 카테고리목록
		public ArrayList<Category> selectCategoryListbyAdmin() {
			// 초기화
			ArrayList<Category> list = null;
			// db 연결 메소드
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
			
			// 에외처리
			try {
				list = new ArrayList<Category>();
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					Category c = new Category();
					c.setCategoryNo(rs.getInt("categoryNo"));
					c.setCategoryKind(rs.getString("categoryKind"));
					c.setCategoryName(rs.getString("categoryName"));
					c.setUpdatedate(rs.getString("updatedate"));
					c.setCreatedate(rs.getString("createdate"));
					list.add(c);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					// db 자원(jdbc api지원) 반납
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}

			return list;
		}
		
		// admin -> insertCategoryAction.jsp
		public int insertCategroy(Category category) {
			// 초기화
			int resultRow = 0;
			// db 연결 메소드
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			int row = 0;
			String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES(?, ?, CURDATE(), CURDATE())";
			
			// 예외처리
			try {
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, category.getCategoryKind());
				stmt.setString(2, category.getCategoryName());
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
		
		// admin -> deleteCategory.jsp
		public int deleteCategory(int categoryNo) {
			// 초기화
			int resultRow = 0;
			// db 연결 메소드
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			int row = 0;
			String sql = "DELETE FROM category WHERE category_no = ?";
			
			// 예외처리
			try {
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, categoryNo);
				row = stmt.executeUpdate();
				if (row == 1) {
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
		
		// admin -> updateCategoryForm.jsp
		public Category selectCategoryOne(int categoryNo) {
			// 초기화
			Category category = null;
			// db 연결 메소드
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT category_no categoryNo, category_name categoryName FROM category WHERE category_no = ?";
			
			// 예외처리
			try {
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, categoryNo);
				rs = stmt.executeQuery();
				if(rs.next()) {
					category = new Category();
					category.setCategoryNo(rs.getInt("categoryNo"));
					category.setCategoryName(rs.getString("categoryName"));
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

			return category;
		}
		
		// admin -> updateCategoryAction.jsp
		public int updateCategoryName(Category category) {
			// 초기화
			int resultRow = 0;
			// db 연결 메소드
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			int row = 0;
			String sql = "UPDATE category SET category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
			
			// 예외처리
			try {
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, category.getCategoryName());
				stmt.setInt(2, category.getCategoryNo());
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

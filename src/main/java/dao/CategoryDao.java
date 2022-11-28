package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;


public class CategoryDao {
	// cash 입력시 <select>목록 출력
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_no ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			categoryList.add(c);
		}
		
		dbUtil.close(rs, stmt, conn);
		
		return categoryList;
	}
	
	// 관리자
	// admin -> 카테고리관리 -> 카테고리목록
		public ArrayList<Category> selectCategoryListbyAdmin() throws Exception {
			ArrayList<Category> list = null;
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
			
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
			
			// db 자원(jdbc api지원) 반납
			dbUtil.close(rs, stmt, conn);
			return list;
		}
		
		// admin -> insertCategoryAction.jsp
		public int insertCategroy(Category category) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			String sql = "INSERT INTO category(category_kind, category_name, updatedate, createdate) VALUES(?, ?, CURDATE(), CURDATE())";
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			
			return row;
		}
		
		// admin -> deleteCategory.jsp
		public int deleteCategory(int categoryNo) throws Exception {
			int row = 0;
			Connection conn = null;
			PreparedStatement stmt = null;
			String sql = "DELETE FROM category WHERE category_no = ?";
			
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			return row;
		}
		
		// admin -> updateCategoryForm.jsp
		public Category selectCategoryOne(int categoryNo) throws Exception {
			Category category = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = "SELECT category_no categoryNo, category_name categoryName FROM category WHERE category_no = ?";
			
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				category = new Category();
				category.setCategoryNo(rs.getInt("categoryNo"));
				category.setCategoryName(rs.getString("categoryName"));
			}
			
			dbUtil.close(rs, stmt, conn);
			
			return category;
		}
		
		// admin -> updateCategoryAction.jsp
		public int updateCategoryName(Category category) throws Exception {
			int row = 0;
			Connection conn = null;
			PreparedStatement stmt = null;
			String sql = "UPDATE category SET category_name = ?, updatedate = CURDATE() WHERE category_no = ?";
			
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryName());
			stmt.setInt(2, category.getCategoryNo());
			row = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			
			return row;
		}
}

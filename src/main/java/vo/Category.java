package vo;

public class Category {
	// 정보은닉
	private int categoryNo;
	private String categoryKind;
	private String categoryName;
	private String updatedate;
	private String createdate;
	
	// 캡슐화
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryKind() {
		return categoryKind;
	}
	public void setCategoryKind(String categoryKind) {
		this.categoryKind = categoryKind;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
	
}

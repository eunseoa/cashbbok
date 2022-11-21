package vo;

public class Cash {
	// 정보은닉
	private int cashNo;
	private int categoryNo; // 외래키가 있으면 INNER JOIN 발생할 수 있음 (Map타입으로 해결)
	private String cashDate;
	private long cashPrize;
	private String cashMemo;
	private String updatedate;
	private String createdate;
	// 캡슐화
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	public long getCashPrize() {
		return cashPrize;
	}
	public void setCashPrize(long cashPrize) {
		this.cashPrize = cashPrize;
	}
	public String getCashMemo() {
		return cashMemo;
	}
	public void setCashMemo(String cashMemo) {
		this.cashMemo = cashMemo;
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

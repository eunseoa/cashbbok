package vo;

public class Help {
	// 정보은닉
	private int helpNo;
	private String helpTitle;
	private String helpMemo;
	private String memberId;
	private String updatedate;
	private String createdate;
	
	public int getHelpNo() {
		return helpNo;
	}
	public void setHelpNo(int helpNo) {
		this.helpNo = helpNo;
	}
	public String getHelpTitle() {
		return helpTitle;
	}
	public void setHelpTitle(String helpTitle) {
		this.helpTitle = helpTitle;
	}
	public String getHelpMemo() {
		return helpMemo;
	}
	public void setHelpMemo(String helpMemo) {
		this.helpMemo = helpMemo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
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

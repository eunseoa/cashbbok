package vo;

public class Notice {
	// 정보은닉
	private int noticeNo;
	private String noticeMemo;
	private String updatedate;
	private String createdate;
	
	// 캡슐화
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public String getNoticeMemo() {
		return noticeMemo;
	}
	public void setNoticeMemo(String noticeMemo) {
		this.noticeMemo = noticeMemo;
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

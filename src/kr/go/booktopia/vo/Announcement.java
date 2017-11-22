package kr.go.booktopia.vo;

public class Announcement extends BaseVo {
	private String title;
	private String content;
	private String charIsEmergency;
	private int viewCount;
	private boolean isEmergency;
	private User admin;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCharIsEmergency() {
		return charIsEmergency;
	}
	public void setCharIsEmergency(String charIsEmergency) {
		this.charIsEmergency = charIsEmergency;
		
	}
	public boolean isEmergency() {
		return isEmergency;
	}
	public void setEmergency(boolean isEmergency) {
		this.isEmergency = isEmergency;
	}
	public User getAdmin() {
		return admin;
	}
	public void setAdmin(User admin) {
		this.admin = admin;
	}
	
	
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	@Override
	public String toString() {
		return String.format(
				"Announcement [title=%s, content=%s, charIsEmergency=%s, viewCount=%s, isEmergency=%s, admin=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				title, content, charIsEmergency, viewCount, isEmergency, admin, id, charIsActive, createdAt, updatedAt);
	}
	
	
	
	
	
}

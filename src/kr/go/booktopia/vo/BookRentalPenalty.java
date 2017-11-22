package kr.go.booktopia.vo;

import java.util.Date;

public class BookRentalPenalty extends BaseVo {
	private int delayDate;
	private Date startDate;
	private Date endDate;
	private User user;
	
	public int getDelayDate() {
		return delayDate;
	}
	public void setDelayDate(int delayDate) {
		this.delayDate = delayDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	@Override
	public String toString() {
		return "BookRentalPanalty [delayDate=" + delayDate + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", user=" + user + ", id=" + id + ", charIsActive=" + charIsActive + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + "]";
	}
	
}

package kr.go.booktopia.vo;

import java.util.Date;

import kr.go.booktopia.util.DateUtil;

public class BookRental extends BaseVo {
	private Date rentalDate;
	private Date expectedReturnDate;
	private Date actualReturnDate;
	private int extraDelayCount;
	private int delayDate;
	private User user;
	private Book book;
	
	public Date getRentalDate() {
		return rentalDate;
	}
	public void setRentalDate(Date rentalDate) {
		this.rentalDate = rentalDate;
	}
	public Date getExpectedReturnDate() {
		return expectedReturnDate;
	}
	public void setExpectedReturnDate(Date expectedReturnDate) {
		this.expectedReturnDate = expectedReturnDate;
	}
	public Date getActualReturnDate() {
		return actualReturnDate;
	}
	public void setActualReturnDate(Date actualReturnDate) {
		this.actualReturnDate = actualReturnDate;
	}
	public int getExtraDelayCount() {
		return extraDelayCount;
	}
	public void setExtraDelayCount(int extraDelayCount) {
		this.extraDelayCount = extraDelayCount;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	
	public int getDelayDate() {
		if (actualReturnDate == null) {
			if (DateUtil.period(expectedReturnDate, new Date()) > 0) {
				return DateUtil.period(expectedReturnDate, new Date());			
			} 
		} else {
			if (DateUtil.period(expectedReturnDate, actualReturnDate) > 0) {
				return DateUtil.period(expectedReturnDate, actualReturnDate);			
			} 
		}		
		return 0;
	}
	
	public String rentalState () {
		if (actualReturnDate != null) {
			return "반납완료";
		}
		if (getDelayDate() > 0 ) {
			return "연체중";
		} else {
			return "대여중";
		}
	}
	
	public void setDelayDate(int delayDate) {
		this.delayDate = delayDate;
	}
	
	@Override
	public String toString() {
		return "BookRental [rentalDate=" + rentalDate + ", expectedReturnDate=" + expectedReturnDate
				+ ", actualReturnDate=" + actualReturnDate + ", extraDelayCount=" + extraDelayCount + ", user=" + user
				+ ", book=" + book + ", id=" + id + ", charIsActive=" + charIsActive + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + "]";
	}	
	
}

package kr.go.booktopia.vo;

import java.util.Date;

public class BookBooking extends BaseVo{
	private Book book;
	private int userId;
	private String uuid;
	private Date bookingDate;
	private Date returnDate;
	private String formatBookingDate;
	private String formatReturnDate;
	
	
	public Book getBook() {
		return book;
	}
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFormatBookingDate() {
		return formatBookingDate;
	}

	public void setFormatBookingDate(String formatBookingDate) {
		this.formatBookingDate = formatBookingDate;
	}

	public String getFormatReturnDate() {
		return formatReturnDate;
	}

	public void setFormatReturnDate(String formatReturnDate) {
		this.formatReturnDate = formatReturnDate;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
		this.formatBookingDate = this.yyyymmdd(this.bookingDate);
	}

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
		this.formatReturnDate = this.yyyymmdd(this.returnDate);
	}

	@Override
	public String toString() {
		return String.format(
				"BookBooking [book=%s, userId=%s, bookingDate=%s, returnDate=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				book, userId, bookingDate, returnDate, id, charIsActive, createdAt, updatedAt);
	}
	
	
}

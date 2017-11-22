package kr.go.booktopia.vo;

public class BookComment extends BaseVo {
	private String content;
	private double ratingPoint;
	private User user;
	private Book book;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public double getRatingPoint() {
		return ratingPoint;
	}
	public void setRatingPoint(double ratingPoint) {
		this.ratingPoint = ratingPoint;
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
	@Override
	public String toString() {
		return String.format(
				"BookComment [content=%s, ratingPoint=%s, user=%s, book=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				content, ratingPoint, user, book, id, charIsActive, createdAt, updatedAt);
	}
	
	
	
	
}

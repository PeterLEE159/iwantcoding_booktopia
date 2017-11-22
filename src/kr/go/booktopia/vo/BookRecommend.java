package kr.go.booktopia.vo;

public class BookRecommend extends BaseVo{
	
	private int bookId;
	private int userId;
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return String.format("BookRecommend [bookId=%s, userId=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				bookId, userId, id, charIsActive, createdAt, updatedAt);
	}
	
	
}

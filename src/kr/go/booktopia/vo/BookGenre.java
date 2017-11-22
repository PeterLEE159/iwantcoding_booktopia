package kr.go.booktopia.vo;

public class BookGenre extends BaseVo {
	private int bookId;
	private int genreId;
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public int getGenreId() {
		return genreId;
	}
	public void setGenreId(int genreId) {
		this.genreId = genreId;
	}
	@Override
	public String toString() {
		return String.format("BookGenre [bookId=%s, genreId=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				bookId, genreId, id, charIsActive, createdAt, updatedAt);
	}
	
	
	
}

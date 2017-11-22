package kr.go.booktopia.vo;

public class BookWish extends BaseVo {
	private String writer;
	private String bookName;
	private String publisher;
	private String accepted;
	private User user;
	private User admin;
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getAccepted() {
		return accepted;
	}
	public void setAccepted(String accepted) {
		this.accepted = accepted;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public User getAdmin() {
		return admin;
	}
	public void setAdmin(User admin) {
		this.admin = admin;
	}
	
	@Override
	public String toString() {
		return "BookWish [writer=" + writer + ", bookName=" + bookName + ", publisher=" + publisher + ", accepted="
				+ accepted + ", user=" + user + ", admin=" + admin + ", id=" + id + ", charIsActive=" + charIsActive
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}	
	
}

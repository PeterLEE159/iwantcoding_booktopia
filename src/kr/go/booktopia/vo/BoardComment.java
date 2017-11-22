package kr.go.booktopia.vo;

public class BoardComment extends BaseVo {
	private String content;
	private Board board;
	private User user;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Override
	public String toString() {
		return String.format(
				"BoardComment [content=%s, board=%s, user=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				content, board, user, id, charIsActive, createdAt, updatedAt);
	}
	
	
}

package kr.go.booktopia.vo;

import java.util.Arrays;

public class Board extends BaseVo {
	private String title;
	private String content;
	private User user;
	private int viewCount;
	private BoardComment[] comments;
	
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
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public BoardComment[] getComments() {
		return comments;
	}
	public void setComments(BoardComment[] comments) {
		this.comments = comments;
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
				"Board [title=%s, content=%s, user=%s, viewCount=%s, comments=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				title, content, user, viewCount, Arrays.toString(comments), id, charIsActive, createdAt, updatedAt);
	}
	
	
	
}

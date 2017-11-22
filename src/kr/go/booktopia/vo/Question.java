package kr.go.booktopia.vo;

public class Question extends BaseVo {
	private String title;
	private String content;
	private int viewCount;
	private User user;
	private QuestionAnswer questionAnswer;
	
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
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public QuestionAnswer getQuestionAnswer() {
		return questionAnswer;
	}
	public void setQuestionAnswer(QuestionAnswer questionAnswer) {
		this.questionAnswer = questionAnswer;
	}
	@Override
	public String toString() {
		return String.format(
				"Question [title=%s, content=%s, viewCount=%s, user=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				title, content, viewCount, user, id, charIsActive, createdAt, updatedAt);
	}
	
	
}

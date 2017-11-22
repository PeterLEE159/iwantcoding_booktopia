package kr.go.booktopia.vo;

public class QuestionAnswer extends BaseVo {
	private String content;
	private int questionId;
	private User admin;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	
	public User getAdmin() {
		return admin;
	}
	public void setAdmin(User admin) {
		this.admin = admin;
	}
	
	@Override
	public String toString() {
		return String.format(
				"QuestionAnswer [content=%s, questionId=%s, admin=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				content, questionId, admin, id, charIsActive, createdAt, updatedAt);
	}
	
	
}

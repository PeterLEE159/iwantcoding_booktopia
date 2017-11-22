package kr.go.booktopia.vo;

public class Genre extends BaseVo {
	
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return String.format("Genre [type=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]", type, id,
				charIsActive, createdAt, updatedAt);
	}
	
}

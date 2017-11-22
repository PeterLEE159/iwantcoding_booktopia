package kr.go.booktopia.vo;

public class BookPublisher extends BaseVo {
	private String name;
	private String phone;
	private String email;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return String.format(
				"BookPublisher [name=%s, phone=%s, email=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]", name,
				phone, email, id, charIsActive, createdAt, updatedAt);
	}
	
}

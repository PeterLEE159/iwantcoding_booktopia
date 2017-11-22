package kr.go.booktopia.vo;

public class User extends BaseVo {
	private String userId;
	private String password;
	private String name;
	private String email;
	private String phone;
	private String charIsAdmin;
	private boolean isAdmin;
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCharIsAdmin() {
		return charIsAdmin;
	}
	public void setCharIsAdmin(String charIsAdmin) {
		this.charIsAdmin = charIsAdmin;
		this.isAdmin = charIsAdmin.equals("Y");
	}
	@Override
	public String toString() {
		return String.format(
				"User [userId=%s, password=%s, name=%s, email=%s, phone=%s, charIsAdmin=%s, isAdmin=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				userId, password, name, email, phone, charIsAdmin, isAdmin, id, charIsActive, createdAt, updatedAt);
	}
	
	
	
	
	
}

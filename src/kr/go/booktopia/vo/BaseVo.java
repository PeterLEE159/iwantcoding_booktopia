package kr.go.booktopia.vo;

import java.util.Date;

import kr.go.booktopia.util.DateUtil;

public abstract class BaseVo {
	protected int id;
	protected String charIsActive;
	protected Date createdAt;
	protected Date updatedAt;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	public String getCharIsActive() {
		return charIsActive;
	}
	public void setCharIsActive(String charIsActive) {
		this.charIsActive = charIsActive;
	}
	public final String getSimpleUpdatedAt() {
		return DateUtil.yyyymmdd(this.updatedAt);
	}
	public final String getSimpleCreatedAt() {
		return DateUtil.yyyymmdd(this.createdAt);
	}
	public final String yyyymmdd(Date date) {
		return DateUtil.yyyymmdd(date);
	}
	
}

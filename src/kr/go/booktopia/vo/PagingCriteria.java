package kr.go.booktopia.vo;

import java.util.List;

public class PagingCriteria {

	private List<BookRental> bookRental;
	private String type;
	private int beginIndex;
	private int endIndex;
	private int beginPage;
	private int endPage;
	private int currentPageNo;
	private int currentBlockNo;
	private Integer userId;
	
	public PagingCriteria() {}

	public List<BookRental> getBookRental() {
		return bookRental;
	}

	public void setBookRental(List<BookRental> bookRental) {
		this.bookRental = bookRental;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getBeginIndex() {
		return beginIndex;
	}

	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}

	public int getEndIndex() {
		return endIndex;
	}

	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public int getCurrentBlockNo() {
		return currentBlockNo;
	}

	public void setCurrentBlockNo(int currentBlockNo) {
		this.currentBlockNo = currentBlockNo;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
}

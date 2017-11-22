package kr.go.booktopia.vo;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.go.booktopia.config.Pagination;

public class Criteria {
	private String opt;
	private String keyword;
	private List<Integer> ids;
	private Integer userId;
	private Integer bookId;
	private Integer searchRange = Pagination.SEARCH_RANGE;
	private Integer page;
	private Integer beginIndex;
	private Integer endIndex;
	private Date date;

	
	public Criteria() {
		
	}
	
	public Criteria(HttpServletRequest req) {
		String page = req.getParameter("page");
		String searchRange = req.getParameter("searchRange");
		if(page == null || page.isEmpty()) page = "1";
		if(searchRange == null || searchRange.isEmpty()) searchRange = String.valueOf(Pagination.SEARCH_RANGE);
		this.page = Integer.parseInt(page);
		this.searchRange = Integer.parseInt(searchRange);
	}

	
	
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public void setEndIndex(Integer endIndex) {
		this.endIndex = endIndex;
	}

	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt; 
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public List<Integer> getIds() {
		return ids;
	}
	public void setIds(List<Integer> ids) {
		this.ids = ids;
	}
	public Integer getSearchRange() {
		return searchRange;
	}
	public void setSearchRange(Integer searchRange) {
		this.searchRange = searchRange;
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
		this.beginIndex = (searchRange * (this.page - 1)) + 1;
		this.endIndex = searchRange * this.page;
	}
	
	public Integer getBookId() {
		return bookId;
	}

	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}

	public Integer getBeginIndex() {
		return beginIndex;
	}

	public void setBeginIndex(Integer beginIndex) {
		this.beginIndex = beginIndex;
	}

	public Integer getEndIndex() {
		return endIndex;
	}

	@Override
	public String toString() {
		return String.format(
				"Criteria [opt=%s, keyword=%s, ids=%s, userId=%s, bookId=%s, searchRange=%s, page=%s, beginIndex=%s, endIndex=%s, date=%s]",
				opt, keyword, ids, userId, bookId, searchRange, page, beginIndex, endIndex, date);
	}

	
}

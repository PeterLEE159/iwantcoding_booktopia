package kr.go.booktopia.dao;

import java.sql.SQLException;
import java.util.List;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.BookRental;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.PagingCriteria;

public class BookDao extends BaseDao {
	
	public int count(PagingCriteria pagingCriteria) throws SQLException {
		return (Integer) IbatisUtil.getClient().queryForObject("BookRental.count", pagingCriteria);
	}
	
	public int countById(PagingCriteria pagingCriteria) throws SQLException {
		return (Integer) IbatisUtil.getClient().queryForObject("BookRental.countById", pagingCriteria);
	}

	@SuppressWarnings("unchecked")
	public List<Book> readLatestBook(Criteria criteria) throws SQLException {  
		return IbatisUtil.getClient().queryForList("Book.readLatestBook", criteria);
	}
	public void delayUpdateById(int no) throws SQLException {
		IbatisUtil.getClient().update("BookRental.delayUpdateById", no);
	}
	
	@SuppressWarnings("unchecked")
	public List<BookRental> getBoardPagingByType(PagingCriteria pagingCriteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("BookRental.getBoardPagingByType", pagingCriteria);
	}	

	@SuppressWarnings("unchecked")
	public List<BookRental> getBoardPagingById(PagingCriteria pagingCriteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("BookRental.getBoardPagingById", pagingCriteria);
	}
	
	@SuppressWarnings("unchecked")
	public List<BookRental> getRentalBookByUserId(PagingCriteria pagingCriteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("BookRental.getRentalBookByUserId", pagingCriteria);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> readByRentalCount(Criteria c) throws SQLException {  
		return IbatisUtil.getClient().queryForList("Book.readByRentalCount", c);
	}
	@SuppressWarnings("unchecked")
	public List<Book> readByRecommentCount(Criteria c) throws SQLException {  
		return IbatisUtil.getClient().queryForList("Book.readByRecommendCount", c);
	}
	
	public int getTotalRows(Criteria criteria) throws SQLException {
		return (int) IbatisUtil.getClient().queryForObject("Book.getTotalRows", criteria);
	}
	
	@SuppressWarnings("unchecked")
	public List<Book> getBooks(Criteria criteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("Book.getBooks", criteria);
	}
	public void returnBook(int rentalId) throws SQLException {
		IbatisUtil.getClient().update("BookRental.returnBook", rentalId);
	}
	
	public int getBookNextVal() throws SQLException {
		return (Integer)IbatisUtil.getClient().queryForObject("Book.getBookNextVal");
	}

	public void bookUpdate(Book b) throws SQLException {
		IbatisUtil.getClient().update("Book.bookUpdate", b);
	}
	
	
	public void addViewCount(Book book) throws SQLException {
		IbatisUtil.getClient().update("Book.addViewCount", book);
	}

}

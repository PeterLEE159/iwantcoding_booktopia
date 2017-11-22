package kr.go.booktopia.dao;

import java.sql.SQLException;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.BookRental;

public class BookRentalDao extends BaseDao {
	
	public BookRental latestBookRental(int bookId) throws SQLException {
		return (BookRental) IbatisUtil.getClient().queryForObject("BookRental.latestBookRental", bookId);
	}
	
	
}

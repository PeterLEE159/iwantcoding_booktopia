package kr.go.booktopia.dao;

import java.sql.SQLException;
import java.util.List;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.BookBooking;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.PagingCriteria;

public class BookingDao {
	
	@SuppressWarnings("unchecked")
	public List<BookBooking> getBookingById(int no) throws SQLException {
		return IbatisUtil.getClient().queryForList("BookBooking.getBookingById", no);
	}
	
	public int bookingCountById(int no) throws SQLException {
		return (Integer) IbatisUtil.getClient().queryForObject("BookBooking.bookingCountById", no);		
	}
	
	@SuppressWarnings("unchecked")
	public List<BookBooking> getBookingPagingById(PagingCriteria pagingCriteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("BookBooking.getBookingPagingById", pagingCriteria);
	}
	
	public List<BookBooking> readByDate(Criteria c) throws SQLException {
		
		return IbatisUtil.getClient().queryForList("BookBooking.readByDate", c);
	}
	
	
}

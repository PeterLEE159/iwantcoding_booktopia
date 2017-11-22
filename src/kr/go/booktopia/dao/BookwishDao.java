package kr.go.booktopia.dao;

import java.sql.SQLException;

import java.util.List;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.BookWish;
import kr.go.booktopia.vo.WishCriteria;



public class BookwishDao {
	
	public int getTotalRows(WishCriteria c) throws SQLException {
		return (Integer)IbatisUtil.getClient().queryForObject("BookWish.getTotalRows",c);
	}
	@SuppressWarnings("unchecked")
	public List<BookWish> getBookWishs(WishCriteria c) throws SQLException {
		return IbatisUtil.getClient().queryForList("BookWish.getBookWishs", c);
	} 
	
	public void bookWishCheckOk(int wishOkId) throws SQLException {
		IbatisUtil.getClient().update("BookWish.bookWishCheckOk", wishOkId);
	}
	public void bookWishCheckNo(int wishNoId) throws SQLException {
		IbatisUtil.getClient().update("BookWish.bookWishCheckNo", wishNoId);
	}
}

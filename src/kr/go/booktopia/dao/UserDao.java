package kr.go.booktopia.dao;

import java.sql.SQLException;
import java.util.List;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.User;

public class UserDao {
	public User getNameandEmail(User user) throws Exception{
		return (User) IbatisUtil.getClient().queryForObject("User.allUser",user);
	}

	
	public User searchPwd(User user) throws Exception{
		return (User) IbatisUtil.getClient().queryForObject("User.searchPwd",user);
	}
	
	public void updatePwd(User user)throws Exception{
		IbatisUtil.getClient().update("User.updatePwd",user);
	}
	
	public User allMembers() throws Exception {
		return (User) IbatisUtil.getClient().queryForObject("User.allMembers");
	}
	
	public int getTotalRows(Criteria criteria) throws SQLException {
		return (int) IbatisUtil.getClient().queryForObject("User.getTotalRows", criteria);
	}
	
	@SuppressWarnings("unchecked")
	public List<User> getUsers(Criteria criteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("User.getUsers", criteria);
	}
	//승환 수정
	public void nonActive(int userOkId) throws SQLException {
		IbatisUtil.getClient().update("User.nonActive", userOkId);
	}
	public void active(int userNoId) throws SQLException {
		IbatisUtil.getClient().update("User.active", userNoId);
	}
	public User searchByUserId(String userId) throws Exception{
		return (User)IbatisUtil.getClient().queryForObject("User.searchUserId",userId);
	}
	public void updatePwds(User user)throws Exception{
		IbatisUtil.getClient().update("User.updatePwds",user);
	}
	
}
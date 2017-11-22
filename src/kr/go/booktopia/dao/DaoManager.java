package kr.go.booktopia.dao;

import java.sql.SQLException;
import java.util.List;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.BaseVo;
import kr.go.booktopia.vo.Criteria;

public class DaoManager {
	private static DaoManager daoManager = new DaoManager();
	
	private DaoManager() { }
	
	public static DaoManager getInstance() {
		return daoManager;
	}
	
	@SuppressWarnings("unchecked")
	public <T> T read(Class<T> className, int id) throws SQLException {
		return (T) IbatisUtil.getClient().queryForObject(className.getSimpleName()+".read", id);
	}
	@SuppressWarnings("unchecked")
	public <T> T read(Class<T> className, String uid) throws SQLException {
		return (T) IbatisUtil.getClient().queryForObject(className.getSimpleName()+".readByUid", uid);
	}

	@SuppressWarnings("unchecked")
	public <T, P> List<T> list(Class<T> className, P p) throws SQLException {
		return IbatisUtil.getClient().queryForList(className.getSimpleName()+".listBy", p);
	}
	@SuppressWarnings("unchecked")
	public <T> List<T> search(Class<T> className, Criteria criteria) throws SQLException {
		return IbatisUtil.getClient().queryForList(className.getSimpleName()+".search", criteria);
	}
	
	@SuppressWarnings("unchecked")
	public <T> List<T> listAll(Class<T> className) throws SQLException {
		return IbatisUtil.getClient().queryForList(className.getSimpleName()+".list");
	}
	
	
	@SuppressWarnings("unchecked")
	public <T> List<T> list(Class<T> className, Criteria criteria) throws SQLException {
		return IbatisUtil.getClient().queryForList(className.getSimpleName()+".list", criteria);
	}
	public <T> void create(T vo) throws SQLException {
		IbatisUtil.getClient().insert(vo.getClass().getSimpleName()+".create", vo);
	}
	public <T> void update(T vo) throws SQLException {
		IbatisUtil.getClient().update(vo.getClass().getSimpleName()+".update", vo);
	}	
	public <T> void delete(T vo) throws SQLException {
		System.out.println(vo);
		IbatisUtil.getClient().update(vo.getClass().getSimpleName()+".delete", vo);
	}
	public <T> void active(T vo) throws SQLException {
		IbatisUtil.getClient().update(vo.getClass().getSimpleName()+".active", vo);
	}
	public <T> int count(Class<T> className) throws SQLException {
		return (Integer) IbatisUtil.getClient().queryForObject(className.getSimpleName()+".count");
	}
	public <T> int count(Class<T> className, int id) throws SQLException {
		return (Integer) IbatisUtil.getClient().queryForObject(className.getSimpleName()+".countById", id);
	}
	
	public <T> int getseq(Class<T> className) throws SQLException {
		return (Integer) IbatisUtil.getClient().queryForObject(className.getSimpleName()+".getseq");
	}
	
	
}

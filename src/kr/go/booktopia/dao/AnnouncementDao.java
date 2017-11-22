package kr.go.booktopia.dao;

import java.sql.SQLException;
import java.util.List;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.Announcement;
import kr.go.booktopia.vo.Criteria;

public class AnnouncementDao extends BaseDao{
	
	public int getTotalRows(Criteria criteria) throws SQLException {
		return (Integer)IbatisUtil.getClient().queryForObject("Announcement.getTotalRows", criteria);
	}
	
	public List<Announcement> getNotices(Criteria criteria) throws SQLException {
		return IbatisUtil.getClient().queryForList("Announcement.getNotices", criteria);
	}
}

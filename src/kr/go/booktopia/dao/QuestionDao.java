package kr.go.booktopia.dao;

import java.sql.SQLException;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.Question;

public class QuestionDao extends BaseDao{
	
	public int getTotalRows(Criteria criteria) throws SQLException {
		return (Integer)IbatisUtil.getClient().queryForObject("Question.getTotalRows", criteria);
	}
	
	public Question getNextQuestion(int id) throws SQLException {
		return (Question) IbatisUtil.getClient().queryForObject("Question.getNextQuestion", id);
	}
	
	public Question getPreQuestion(int id) throws SQLException {
		return (Question) IbatisUtil.getClient().queryForObject("Question.getPreQuestion", id);
	}
}

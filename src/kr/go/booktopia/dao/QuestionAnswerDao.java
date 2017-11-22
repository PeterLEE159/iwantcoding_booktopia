package kr.go.booktopia.dao;

import java.sql.SQLException;

import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.vo.QuestionAnswer;

public class QuestionAnswerDao {
	public QuestionAnswer getLatestAnswer(int questionId) throws SQLException {
		return (QuestionAnswer) IbatisUtil.getClient().queryForObject("QuestionAnswer.getLatestAnswer", questionId);
	}
}

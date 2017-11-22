<%@page import="kr.go.booktopia.vo.Question"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int id = Integer.parseInt(request.getParameter("id"));

	DaoManager daoManager = DaoManager.getInstance();
	
	Question question = daoManager.read(Question.class, id);
	question.setViewCount(question.getViewCount() + 1);
	
	daoManager.update(question);
	
	response.sendRedirect("detail.jsp?id="+id);
	
%>
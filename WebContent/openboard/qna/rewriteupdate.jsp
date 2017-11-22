<%@page import="kr.go.booktopia.vo.User"%>
<%@page import="kr.go.booktopia.vo.Question"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>  
<%
	request.setCharacterEncoding("utf-8");

	int id = Integer.parseInt(request.getParameter("id"));	
	
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	DaoManager daoManager = DaoManager.getInstance();
	Question question = daoManager.read(Question.class, id);
	
	question.setTitle(title);
	question.setContent(content);
	
	daoManager.update(question);
	
	response.sendRedirect("detail.jsp?id="+id);
	
%>
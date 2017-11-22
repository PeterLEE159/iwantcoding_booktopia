<%@page import="kr.go.booktopia.vo.User"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.Question"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>   
<%

	request.setCharacterEncoding("utf-8");
	
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Question question = new Question();
	
	User user = (User) session.getAttribute("userInfo");
	
	question.setTitle(title);
	question.setContent(content);
	question.setUser(user);
	
	DaoManager daoManager = DaoManager.getInstance();
	daoManager.create(question);
	
	response.sendRedirect("/openboard/qna/list.jsp");
	
%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@page import="kr.go.booktopia.vo.QuestionAnswer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>  
<%

	request.setCharacterEncoding("utf-8");
	
	int qnaid = Integer.parseInt(request.getParameter("qnaid"));
	String content = request.getParameter("content");
	
	QuestionAnswer questionAnswer = new QuestionAnswer();
	
	User adminUser = (User) session.getAttribute("userInfo");
	
	questionAnswer.setContent(content);
	questionAnswer.setQuestionId(qnaid);
	questionAnswer.setAdmin(adminUser);
	
	DaoManager daoManager = DaoManager.getInstance();
	daoManager.create(questionAnswer);
	
	response.sendRedirect("detail.jsp?id="+qnaid);
%>
<%@page import="kr.go.booktopia.vo.QuestionAnswer"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL2.jsp" %>  
<%
	
	
	request.setCharacterEncoding("utf-8");

	int id = Integer.parseInt(request.getParameter("qnaid"));	

	User userInfo = (User) session.getAttribute("userInfo");
	
	String content = request.getParameter("content");

	DaoManager daoManager = DaoManager.getInstance();
	QuestionAnswer questionAnswer = daoManager.read(QuestionAnswer.class, id);

	questionAnswer.setContent(content);
	questionAnswer.setAdmin(userInfo);
		
	daoManager.update(questionAnswer);
	
	response.sendRedirect("detail.jsp?id="+id);
	
%>
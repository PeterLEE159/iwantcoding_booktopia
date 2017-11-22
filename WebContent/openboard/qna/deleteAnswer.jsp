<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.QuestionAnswer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>  
<%
	int id = Integer.parseInt(request.getParameter("qnaid"));

	DaoManager daoManager = DaoManager.getInstance();
	QuestionAnswer questionAnswer = daoManager.read(QuestionAnswer.class, id);
	
	daoManager.delete(questionAnswer);
	
	response.sendRedirect("detail.jsp?id="+id);
%>
<%@page import="kr.go.booktopia.vo.Question"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>   
<%
	int id = Integer.parseInt(request.getParameter("id"));

	DaoManager daoManager = DaoManager.getInstance();
	
	Question question = daoManager.read(Question.class, id);
	
	daoManager.delete(question);
	
	response.sendRedirect("list.jsp");
%>
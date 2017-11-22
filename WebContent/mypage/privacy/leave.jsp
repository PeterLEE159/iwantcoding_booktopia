<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<%
	User user = (User) session.getAttribute("userInfo");
	
	DaoManager daoManager = DaoManager.getInstance();
	daoManager.delete(user);
	
	session.invalidate();
	response.sendRedirect("../../index.jsp");
%>
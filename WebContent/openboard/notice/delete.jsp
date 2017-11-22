<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL2.jsp" %> 
<%
	int id = Integer.parseInt(request.getParameter("id"));

	DaoManager daoManager = DaoManager.getInstance();
	
	Announcement announcement = daoManager.read(Announcement.class, id);
	
	daoManager.delete(announcement);
	
	response.sendRedirect("list.jsp");
%>
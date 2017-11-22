<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int id = Integer.parseInt(request.getParameter("id"));

	DaoManager daoManager = DaoManager.getInstance();
	
	Announcement announcement = daoManager.read(Announcement.class, id);
	announcement.setViewCount(announcement.getViewCount() + 1);
	
	daoManager.update(announcement);
	
	response.sendRedirect("detail.jsp?id="+id);
%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");	
	

	User user = new User();
	DaoManager dao = DaoManager.getInstance();
	
	User checkId = dao.read(User.class, id);
	String state = null;
	if(checkId != null){
		state = "1";
	}else{
		state = "2";
	}
	response.getWriter().write(state);
%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String userNoId = request.getParameter("id");
	System.out.println(userNoId);

	if(userNoId == null || userNoId.isEmpty()) throw new ServletException("유효하지 않은 요청입니다");
	
	System.out.println(userNoId);
	
	UserDao ud = new UserDao();
	ud.active(Integer.parseInt(userNoId));
	
	out.println(true);







%>
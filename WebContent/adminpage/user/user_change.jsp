<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String userOkId = request.getParameter("id");
	System.out.println(userOkId);

	if(userOkId == null || userOkId.isEmpty()) throw new ServletException("유효하지 않은 요청입니다");
	
	System.out.println(userOkId);
	
	UserDao ud = new UserDao();
	ud.nonActive(Integer.parseInt(userOkId));
	
	out.println(true);







%>
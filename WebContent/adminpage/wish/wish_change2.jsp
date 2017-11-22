<%@page import="kr.go.booktopia.dao.BookwishDao"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String wishNoId = request.getParameter("id");
	System.out.println(wishNoId);

	if(wishNoId == null || wishNoId.isEmpty()) throw new ServletException("유효하지 않은 요청입니다");
	
	
	
	BookwishDao bwd = new BookwishDao();
	bwd.bookWishCheckNo(Integer.parseInt(wishNoId));
	
	out.println(true);







%>
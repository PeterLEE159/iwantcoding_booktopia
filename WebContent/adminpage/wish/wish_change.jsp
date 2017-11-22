<%@page import="kr.go.booktopia.dao.BookwishDao"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String wishOkId = request.getParameter("id");
	System.out.println(wishOkId);

	if(wishOkId == null || wishOkId.isEmpty()) throw new ServletException("유효하지 않은 요청입니다");
	
	
	
	BookwishDao bwd = new BookwishDao();
	bwd.bookWishCheckOk(Integer.parseInt(wishOkId));
	
	out.println(true);







%>
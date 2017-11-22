<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Date"%>
<%@page import="kr.go.booktopia.vo.BookRental"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String rentalId = request.getParameter("id");
	
	
	if(rentalId == null || rentalId.isEmpty())
		throw new ServletException("유효한 요청이 아닙니다");
	
	System.out.println(rentalId);
	
	
	
	new BookDao().returnBook(Integer.parseInt(rentalId));
	
	
	
	out.println(true);
	
%>


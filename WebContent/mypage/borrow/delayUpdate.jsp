<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>  
<%
	int no = Integer.parseInt(request.getParameter("no"));
	int p = Integer.parseInt(request.getParameter("p"));
	String type = request.getParameter("type");

	BookDao bookDao = new BookDao();
	bookDao.delayUpdateById(no);
	
	response.sendRedirect("/mypage/borrow/borrow.jsp?p=" + p + "&type=" + type);
%>
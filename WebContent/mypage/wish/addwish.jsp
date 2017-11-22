<%@page import="kr.go.booktopia.vo.User"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.BookWish"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<%		
		request.setCharacterEncoding("utf-8");

		User user = (User) session.getAttribute("userInfo");

		String bookName = request.getParameter("bookname");
		String writer = request.getParameter("writer");
		String publisher = request.getParameter("publisher");		
		
		BookWish bookWish = new BookWish();
		bookWish.setBookName(bookName);
		bookWish.setWriter(writer);
		bookWish.setPublisher(publisher);
		bookWish.setUser(user);
		
		DaoManager daoManager = DaoManager.getInstance();
		
		daoManager.create(bookWish);
		
		response.sendRedirect("complete.jsp");	
%>
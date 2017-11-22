<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<%
	User user = (User) session.getAttribute("userInfo");
	
	String mobile = request.getParameter("mobile");
	String firstN = request.getParameter("firstN");
	String lastN = request.getParameter("lastN");
	
	String email = request.getParameter("email");
	
	user.setPhone(mobile + firstN + lastN);
	user.setEmail(email);
	
	DaoManager daoManager = DaoManager.getInstance();
	daoManager.update(user);
	
	response.sendRedirect("/mypage/borrow/borrow.jsp");
%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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

		String userpwd = request.getParameter("userpwd");
		
		String sha256UserPwd = DigestUtils.sha256Hex(userpwd);
		
		if(!user.getPassword().equals(sha256UserPwd)){	
			response.sendRedirect("/mypage/privacy/user.jsp?fail=1");
		    return;
		} else {
			response.sendRedirect("uinfou.jsp");   
		}			
%>
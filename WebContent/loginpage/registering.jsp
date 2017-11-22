<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String userId = request.getParameter("register-id");
	String pwd = request.getParameter("register-pwd");
	String name = request.getParameter("register-name");
	String phone = request.getParameter("register-phone");
	String email = request.getParameter("register-email");
	String sha256Pwd = DigestUtils.sha256Hex(pwd);
	
	DaoManager dao = DaoManager.getInstance();
	User userCheck = dao.read(User.class, userId);

	if (userCheck == null ) {
		User user = new User();

		user.setUserId(userId);
		user.setPassword(sha256Pwd);
		user.setName(name);
		user.setPhone(phone);
		user.setEmail(email);
		
		dao.create(user);	
		
		response.sendRedirect("../index.jsp");
		
	} else {
		System.out.println("안됨.");
		return;
	}
%>
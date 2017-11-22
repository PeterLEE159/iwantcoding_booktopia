<%@page import="kr.go.booktopia.util.MailUtil"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*,
   java.io.*,
   javax.mail.*,
   javax.mail.internet.*,
   javax.activation.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("username");
	String email = request.getParameter("useremail");

	User user = new User();
	UserDao dao = new UserDao();
	user.setName(name);
	user.setEmail(email);
	User userInfo = dao.getNameandEmail(user);

	if (userInfo != null) {
		//제목
		String subject = "[Booktopia] 아이디를 알려드립니다.";
		//내용
		String contents = "고객님의 아이디는 : " + userInfo.getUserId() + "입니다.";
		// 받는이 메일주소 
		String to = userInfo.getEmail();
		// 보내는이 메일주소
		String from = "leeshva093091@gmail.com";

		MailUtil.sendEmail(subject, contents, to);

		response.sendRedirect("../index.jsp");
	} else {
%>
<div class="alert alert-danger">
	
	<%
		response.sendRedirect("searchid.jsp?searchIdFail=1");
	%>
</div>
<%
	}
%>
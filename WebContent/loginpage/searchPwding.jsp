<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="org.apache.catalina.authenticator.DigestAuthenticator"%>
<%@page import="java.util.Random"%>
<%@page import="kr.go.booktopia.util.MailUtil"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("userid");
	String name = request.getParameter("username");
	String email = request.getParameter("useremail");

	User user = new User();
	UserDao dao = new UserDao();
	user.setUserId(id);
	user.setName(name);
	user.setEmail(email);

	User userInfo = dao.searchPwd(user);
	String str = "";
	int d = 0;
	for (int i = 1; i <= 8; i++) {
		Random r = new Random();
		d = r.nextInt(9);
		str = str + Integer.toString(d);
	}

	if (userInfo != null) {
		String newPwd = DigestUtils.sha256Hex(str);
		userInfo.setPassword(newPwd);
		dao.updatePwd(userInfo);

		//제목
		String subject = "[Booktopia] 임시비밀번호를 알려드립니다.";
		//내용
		String contents = "고객님의 임시비밀번호는 : " + str + "입니다.";
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

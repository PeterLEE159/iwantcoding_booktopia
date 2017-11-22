<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>

	<div class="container">
		<%
			request.setCharacterEncoding("utf-8");

		 	String userId = request.getParameter("userId");
			String pass = request.getParameter("password");
			String passCheck = request.getParameter("rpassword");
			if (pass.equals(passCheck)) {
				User user = new User();
				UserDao dao = new UserDao();
	
				user = dao.searchByUserId(userId);
				String newPwd = DigestUtils.sha256Hex(pass);
				user.setPassword(newPwd);

				dao.updatePwds(user);

				response.sendRedirect("/mypage/privacy/uinfou.jsp");
			} else {
				response.sendRedirect("/mypage/privacy/updatepwd.jsp?fail=1");
			}
		%>
	</div>
</body>
<script type="text/javascript">

</script>
</html>
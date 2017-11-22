<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%@ include file="/common/navbar.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<%
		if (request.getParameter("fail") != null) {
	%>
	<a href="javascript:alert()"></a>
	<%
		}
	%>
	<%
		if ("1".equals(request.getParameter("deny"))) {
	%>
	<div class="alert alert-danger">
		<strong>오류</strong> 로그인이 필요한 페이지 입니다.
	</div>
	<%
		} else if ("2".equals(request.getParameter("deny"))){
	%>
	<div class="alert alert-danger">
		<strong>오류</strong> 관리자만 이용가능한 페이지 입니다.
	</div>
		<%} %>
	<%
		returnUrl = request.getParameter("returnUrl");
	%>
	<div class="row">
		<form class="form-horizontal" action="/loginpage/logining.jsp"
			method="post">
			<%
				if (returnUrl != null) {
			%>
			<input type="hidden" name="returnUrl" value="<%=returnUrl%>">
			<%
				}
			%>
			<div class="form-group">
				<label class="col-md-4 control-label" for="id">아이디</label>
				<div class="col-md-4">
					<input id="id" name="inputLoginId" type="text" placeholder="아이디"
						class="form-control input-md" required="">
				</div>
				<div id="idCheck"></div>
			</div>


			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="password">비밀번호 </label>
				<div class="col-md-4">
					<input id="password" name="inputLoginPwd" type="password"
						placeholder="Password " class="form-control input-md" required="">
				</div>

			</div>
			<div class="form-group text-center">
				<a href="/loginpage/searchid.jsp" class="login-form-options">아이디찾기</a>
				<a href="/loginpage/searchpwd.jsp" class="login-form-options">
					비밀번호 찾기</a> <a href="" class="login-form-options"> 회원가입</a>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="save"></label>
				<div class="col-md-8">
					<input type="submit" value="로그인" class="btn btn-success"> <a
						href="" id="cancel" class="btn btn-danger">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
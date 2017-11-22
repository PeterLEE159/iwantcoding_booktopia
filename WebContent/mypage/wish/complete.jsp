<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 회원정보 수정</title>
</head>
<body>
<% pageContext.setAttribute("url","/index.jsp"); %>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/mypage-side.jsp" %>
		</div>
		<div class="col-sm-7 contents text-center">
			<h3 style="margin-top: 100px;">희망도서 신청이 완료되었습니다.</h3>
			<a href="/mypage/wish/wishbook.jsp" class="btn btn-primary">확인</a>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>
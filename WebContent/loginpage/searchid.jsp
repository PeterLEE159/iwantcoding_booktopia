<%@page import="kr.go.booktopia.util.MailUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 아이디 찾기</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<%
	String searchIdFail = request.getParameter("searchIdFail");

	if(searchIdFail != null){%>
		<script>
			alert('해당 내용과 일치하는 정보가 없습니다.');
		</script>
	<% } %>

	<div class="container">
		<form class="form-horizontal" action="/loginpage/searchIding.jsp">
	        <!-- Form Name -->
	        <h1 class="text-center">아이디찾기</h1>
	    	<div class="well">
		        <!-- Text input-->
		        <div class="form-group ">
		          <label class="col-md-4 control-label" for="name">이름</label>  
		          <div class="col-md-4">
		      	    <input id="user-name" name="username" type="text" placeholder="이름" class="form-control input-md">  
		          </div>
		        </div>
	
		        <!-- Text input-->
		        <div class="form-group">
		          <label class="col-md-4 control-label" for="email">이메일</label>  
		          <div class="col-md-4">
		         	 <input id="user-email" name="useremail" type="email" placeholder="Email address" class="form-control input-md">
		          </div>    
		        </div>
		
		        <!-- Button (Double) -->
		        <div class="form-group">
		          <label class="col-md-4 control-label" for="submit"></label>
		          <div class="col-md-8">
		            <button id="searchId" name="submit" class="btn btn-success" type="submit">ID찾기</button>
		            <a href="/index.jsp" id="cancel" name="cancel" class="btn btn-danger">취소</a>
		          </div>
		        </div>
	        </div>       
		</form>
	</div>
<%@ include file="/common/footer.jsp" %>
</body>

</html>

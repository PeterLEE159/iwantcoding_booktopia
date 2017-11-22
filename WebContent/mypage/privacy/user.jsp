<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 회원정보 확인</title>
</head>
<body>
<%
	pageContext.setAttribute("url","/mypage/privacy/user.jsp");
	pageContext.setAttribute("sideMode", "userinfo");
%>

<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL.jsp" %> 
<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/mypage-side.jsp" %>
		</div>
		<div class="col-sm-7 contents">
			<h3>회원 정보수정</h3>
		  <hr class="colorgraph">
		     <p><strong>비밀번호 재입력</strong></p>
		     <p>&#8251; 회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 입력하시기 바랍니다.</p>
		     <p>&#8251; 항상 비밀번호는 타인에 노출되지 않게 관리하시기 바랍니다.</p>
		  <hr class="colorgraph">
		  <form action="pwdcheck.jsp" method="post">
			   <div class="row text-center">
			       <div class="col-lg-2">
			           <label>아이디</label>
			       </div>
			       <div class="col-lg-5">
			           <div class="form-group">
			               <input id="user-id" type="text" class="form-control" value="<%=user.getUserId() %>" disabled="disabled"/>
			           </div>
			       </div>
			   </div>
			   <div class="row text-center">
			       <div class="col-lg-2">
			           <label>비밀번호</label>
			       </div>
			       <div class="col-lg-5">
			           <div class="form-group">
			           		<input id="user-pwd" type="password" name="userpwd" class="form-control" />
			           </div>
			           <%
			           	int fail = 100;
			           	try {
			       			fail = Integer.parseInt(request.getParameter("fail"));
			       		} catch (NumberFormatException e) {}
			           	if (fail == 1) {
			           %>
			           <p class="alert alert-danger">비밀번호를 잘못입력하셨습니다.</p>
			           <%
			           	}
			           %>			           
			       </div>			       
			   </div>				   	
		       <div class="row" style="margin-left:150px;">
		       		<button type="submit" id="ok-btn" class="btn btn-primary">확인</button>		         
		            <a href="/mypage/borrow/borrow.jsp" id="x-btn" class="btn btn-default">취소</a>
		       </div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>
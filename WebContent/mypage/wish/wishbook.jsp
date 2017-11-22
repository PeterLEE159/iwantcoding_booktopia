<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 희망도서 신청</title>
</head>
<body>
<% 
	pageContext.setAttribute("url","/mypage/wish/wishbook.jsp");
	pageContext.setAttribute("sideMode", "wish");
%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/mypage-side.jsp" %>
		</div>
		<div class="col-sm-7 contents">
			<div class="row" style="margin-top: 30px">
	         <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
	            <form action="addwish.jsp" method="post">
	               <fieldset>
	                  <h2 class="text-center">희망도서신청</h2>
	                  <hr class="colorgraph">
	                  <div>
	                     <div class="form-group">
	                        <label>책 제목</label>
	                        <input type="text" name="bookname" id="book-name"
	                           class="form-control input-lg" required="">
	                     </div>
	                     <div class="form-group">
	                        <label>저자</label>
	                        <input type="text" name="writer" id="book-writer"
	                           class="form-control input-lg" required="">
	                     </div>
	                     <div class="form-group">
	                        <label>출판사</label>
	                        <input type="text" name="publisher" id="book-publisher"
	                           class="form-control input-lg" required="">
	                     </div>
	                  </div>
	                  
	               </fieldset>	            
	                  <hr class="colorgraph">
		            <div class="row">
		               <div class="text-center">
		                  <button class="btn btn-success btn-lg" type="submit">희망도서신청</button>
		               </div>
		            </div>
	            </form>
	         </div>
      		</div>
		</div>
	</div>
</div>	      
<%@ include file="/common/footer.jsp" %>
</body>
</html>
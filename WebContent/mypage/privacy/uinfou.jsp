<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<%@ include file="/common/navbar.jsp" %>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 회원정보 수정</title>
</head>
<body>
<%pageContext.setAttribute("url","/mypage/privacy/uinfou.jsp");%>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<%	
	String id = user.getUserId();
	String name = user.getName();
	
	String phone = user.getPhone();
	
	String mobile = phone.substring(0, 3);
	String firstN = phone.substring(3, 7);
	String lastN = phone.substring(7);
%>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/mypage-side.jsp" %>
		</div>
		<div class="col-sm-7 contents">
			<form class="form-horizontal" method="post" action="updateuserinfo.jsp">
				<h3 class="text-center">회원정보수정</h3>
				<hr class="colorgraph">
				
				<!-- Text input-->
				<div class="form-group">
					<label class="col-md-3 control-label">아이디</label>  
					<div class="col-md-6">
						<label class="control-label"><%=id %></label>
					</div>
				</div>
				
				<div class="form-group">
				  <label class="col-md-3 control-label">비밀번호 입력</label>  
				  <div class="col-md-6">
				  <a href="/mypage/privacy/updatepwd.jsp" class="btn btn-default">수정하기</a>
				  </div>
				</div>
				
				<div class="form-group">
					<label class="col-md-3 control-label">이름</label>  
					<div class="col-md-6">
						<label class="control-label"><%=name %></label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-3 control-label">전화번호</label>  
						<div class="col-md-2">
							<select class="form-control" name="mobile">
								<option value="010" <%="010".equals(mobile) ? "selected" : "" %>>010</option>
								<option value="011" <%="011".equals(mobile) ? "selected" : "" %>>011</option>
								<option value="017" <%="017".equals(mobile) ? "selected" : "" %>>017</option>
								<option value="019" <%="019".equals(mobile) ? "selected" : "" %>>019</option>
							</select>
						</div>
						<div class="col-md-2">
							<input type="text" id="phone" name="firstN" value="<%=firstN %>" class="form-control input-md" />
						</div>
						<div class="col-md-2">
							<input type="text" id="phone1" name="lastN" value="<%=lastN %>" class="form-control input-md" />
						</div>
				</div>
				
				<div class="form-group">
				  <label class="col-md-3 control-label">이메일</label>  
				  <div class="col-md-6">
				  <input type="text" id="email" placeholder="수정할 이메일을 입력해주세요." name="email" value="<%=user.getEmail() %>" class="form-control input-md" >
				  </div>
				</div>
				
				
				<div class="form-group">
				  <label class="col-md-3 control-label"></label>  
				<div class="col-md-7">
				    <a href="/mypage/privacy/user.jsp" class="btn btn-danger">이전</a>
				    <button type="submit" class="btn btn-success">수정</button>
				</div>
				</div>
			</form>
			
			<hr class="colorgraph">
			
			<div class="text-center">
				<button class="btn btn-default" id="leave">회원탈퇴</button>
			</div>
		
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
   $(document).ready(function(){
      $("#phone").keyup(function(event){
         if(!(event.keyCode>=37&&event.keyCode<=40)){
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
         }
      })
   })
   $(document).ready(function(){
      $("#phone1").keyup(function(event){
         if(!(event.keyCode>=37&&event.keyCode<=40)){
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
         }
      })
   })
   
</script>
</html>
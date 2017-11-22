<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 비밀번호 변경</title>
</head>
<body>
<%pageContext.setAttribute("url","/mypage/privacy/updatepwd.jsp");%>
	<%@ include file="/common/navbar.jsp"%>
<%@ include file="/loginpage/login_returnURL.jsp" %>
	<div class="container">
		<div class="row">
			<div class="col-sm-2 side">
				<%@ include file="/common/mypage-side.jsp"%>
			</div>
			<div class="col-sm-7 contents">
				<!-- Form Name -->
				<div class="row text-center">
					<h3>비밀번호 변경</h3>
				</div>
				<form class="form-horizontal" action="updatepwding.jsp">
					<input type="hidden" name="userId" value="<%=user.getUserId()%>">
					<fieldset>
						<!-- Password input-->
						<div class="form-group">
							<label class="col-md-4 control-label" for="password">새
								비밀번호 </label>
							<div class="col-md-4">
								<input id="password" name="password" type="password"
									placeholder="Password " class="form-control input-md">
									<div id="pwd"></div>
							</div>
						</div>

						<!-- Password input-->
						<div class="form-group">
							<label class="col-md-4 control-label" for="rpassword">비밀번호확인</label>
							<div class="col-md-4">
								<input id="rpassword" name="rpassword" type="password"
									placeholder="Password" class="form-control input-md">
								<span class="help-block">비밀번호를
									다시 입력하세요</span>
								<div id="pwdOk"></div>
							</div>
						</div>
						<!-- Button (Double) -->
						<div class="form-group">
							<label class="col-md-4 control-label" for="save"></label>
							<div class="col-md-8">
								<input type="submit" id="infoChange" value="변경하기" class="btn btn-success">
								<a href="/mypage/privacy/uinfou.jsp" id="cancel"
									class="btn btn-danger">취소</a>
							</div>
						</div>

					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="/common/footer.jsp"%>
</body>
<script type="text/javascript">
   document.getElementById("password").addEventListener("blur", function(event) {
//       var pwd = this.value;
      var pwd = document.getElementById("password").value;
      var content = "";
      
      if (pwd.length <= 3 || pwd.length > 12) {
         content += "<p style='color:red'>비밀번호를 4~12자리로 해주세요</p>";
         
      }
      document.getElementById("pwd").innerHTML = content;
   });

   document.getElementById("infoChange").addEventListener("click", function(event) {
      var pwd = document.getElementById("password").value;
      var pwdOk = document.getElementById("rpassword").value;
      var content = "";

      if (pwd === pwdOk) {
         content += "<p style='color:#82ba44'>비밀번호가 일치합니다.</p>";
         if(pwd.length <= 3 || pwd.length>12){
            event.preventDefault();
            alert("비밀번호를 4~12자리로 해주세요");
            content = "<p style='color:red'>비밀번호를 4~12자리로 해주세요</p>";

         }
      } else {
         event.preventDefault();
         content += "<p style='color:red'>비밀번호를 확인하세요.</p>";
      }
      document.getElementById("pwdOk").innerHTML = content;
   });

</script>
</html>
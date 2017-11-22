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
<%@ include file="/common/navbar.jsp"%>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 회원가입</title>
</head>
<div>
	<%
		final String FAIL_CODE_DUP_ID = "1";
		final String FAIL_CODE_SHORT_PWD = "2";

		String failCode = request.getParameter("fail");
		
		
	%>

	<%
		if (FAIL_CODE_DUP_ID.equals(failCode)) {
	%>
	<div class="alert alert-danger">
		<strong>오류</strong> 이미 사용중인 아이디 입니다.
	</div>
	<%
		}
	%>
	<%
		if (FAIL_CODE_SHORT_PWD.equals(failCode)) {
	%>
	<div class="alert alert-danger">
		<strong>오류</strong> 비밀번호는 8글자 이상 입력하시기 바랍니다.
	</div>
	<%
		}
	%>
	<form class="form-horizontal" action="registering.jsp" method="post">
		<fieldset>

			<!-- Form Name -->
			<div class="container text-center">
				<h1 style="color: #82ba44;">회원가입</h1>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="id">아이디</label>
				<div class="col-md-4">
					<input id="id" name="register-id" type="text" placeholder="아이디"
						class="form-control input-md" required="" onkeyup="fn_press_han(this);"  onblur="fn_press_han(this);">
				</div>
				<div id="idCheck"></div>
			</div>


			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="password">비밀번호 </label>
				<div class="col-md-4">
					<input id="password" name="register-pwd" type="password"
						placeholder="Password " class="form-control input-md" required="">
				</div>
			</div>

			<!-- Password input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="rpassword">비밀번호확인</label>
				<div class="col-md-4">
					<input id="rpassword" name="register-pwdOk" type="password"
						placeholder="비밀번호를 다시 입력하세요" class="form-control input-md"
						required="">
				</div>
				<div id="pwdOk"></div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="name">이름</label>
				<div class="col-md-4">
					<input id="name" name="register-name" type="text" placeholder="이름"
						class="form-control input-md" required="">
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="phone">연락처</label>
				<div class="col-md-4">
					<input id="phone" name="register-phone" type="text"
						placeholder="연락처를 입력해주세요." class="form-control input-md"
						required=""> <span class="help-block"> '-'없이 숫자만
						입력하세요</span>
				</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
				<label class="col-md-4 control-label" for="email">이메일</label>
				<div class="col-md-4">
					<input id="email" name="register-email" type="email"
						placeholder="이메일을 입력해주세요." class="form-control input-md"
						required="">
				</div>

			</div>


			<!-- Button (Double) -->
			<div class="form-group">
				<label class="col-md-4 control-label" for="save"></label>
				<div class="col-md-8">
					<input type="submit" id="join" value="가입하기" class="btn btn-success">
					<a href="/index.jsp" id="cancel" class="btn btn-danger">취소</a>
				</div>
			</div>

		</fieldset>
	</form>
</div>
<%@ include file="/common/footer.jsp"%>
</body>
<script type="text/javascript">
	document.getElementById("id").addEventListener("blur", function(event) {

		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var data = xhr.responseText;
				var htmlContent = "";
				
				if (data == "1") {
					htmlContent = "<p style='color:red'>중복된 아이디입니다</p>";
					document.getElementById("id").value = "";
				}else if(data == "2"){
					htmlContent = "<p style='color:#82ba44'>사용가능한 아이디입니다</p>";					
				}
				if(document.getElementById("id").value == "" ){
					htmlContent = "<p style='color:red'>아이디를 입력해주세요</p>";
				}else if(document.getElementById("id").value.length >12 || document.getElementById("id").value.length <4){
					htmlContent = "<p style='color:red'>4~12자 내외로 해주세요</p>";
				}

				document.getElementById("idCheck").innerHTML = htmlContent;
			}
			
		};

		xhr.open("GET", "/loginpage/loginCheck.jsp?id=" + document.getElementById("id").value);

		xhr.send(null);
	});
	
	document.getElementById("password").addEventListener("blur", function(event) {
		var pwd = this.value;

		if (pwd.length == 1||pwd.length == 2 ||pwd.length==3||pwd.length==4||pwd.length > 13) {
			alert("비밀번호를 4~12 자리로 해주세요");
			this.value="";
			this.focus();
		}
	});

	document.getElementById("rpassword").addEventListener("blur", function(event) {
		var pwd = document.getElementById("password").value;
		var pwdOk = document.getElementById("rpassword").value;
		var content = "";

		if (pwd === pwdOk) {
			content += "<p style='color:#82ba44'>비밀번호가 일치합니다.</p>";
		} else {
			content += "<p style='color:red'>비밀번호가 틀립니다.</p>";
		}
		document.getElementById("pwdOk").innerHTML = content;
	});
	
	function fn_press_han(obj)
	{
	    if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39
	    || event.keyCode == 46 ) return;
	    //obj.value = obj.value.replace(/[\a-zㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	    var regexp = /[\ㄱ-ㅎㅏ-ㅣ가-힣]/g;
	    console.log(obj);
	    if (regexp.test(obj.value)) {
	       obj.value = "";
	    } 
	}
	$(document).ready(function(){
		$("#phone").keyup(function(event){
			if(!(event.keyCode >= 37 && event.keyCode<=40)){
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^0-9]/gi,''));	
			}
		})
	})
	
	$(document).ready(function(){
		$("#name").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)){
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[a-z0-9]/gi,''));
			}
		})
	})
	
	$(document).ready(function(){
		$("#id").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)){
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
			}
		})
	})
	document.getElementById("name").addEventListener("blur", function(event){
		var name = this.value;

		if (name.length >5) {
			alert("이름은 2~5 자리로 해주세요.....");
			this.value="";
			this.focus();
		}else{
			return;
		}
	})
	document.getElementById("phone").addEventListener("blur", function(event){
		var phone = this.value;

		if (phone.length > 12) {
			alert("유효하지 않은 번호입니다 번호를 다시 확인해 주세요.");
			this.value="";
			this.focus();
			
		}
	})
	
	document.getElementById("join").addEventListener("click",function(event){
		var phone = document.getElementById("phone").value;
		
		if(phone.length != 11){
			phone.value="";
			event.preventDefault();
			alert("유효하지 않은 번호입니다 번호를 다시 확인해 주세요.");
			phone.focus();
		}
	})
	
</script>
</html>
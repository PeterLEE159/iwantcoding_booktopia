<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 비밀번호 변경</title>
</head>
<body>
	<%@ include file="/common/navbar.jsp"%>
	<%
		String searchIdFail = request.getParameter("searchIdFail");

		if (searchIdFail != null) {
	%>
	<script>
		alert('해당 내용과 일치하는 정보가 없습니다.');
	</script>
	<%
		}
	%>
	<div class="container">
		<form class="form-horizontal" action="/loginpage/searchPwding.jsp">
			<!-- Form Name -->
			<h1 class="text-center">비밀번호 찾기</h1>
			<div class="well">
				<!-- Text input-->
				<div class="form-group ">
					<label class="col-md-4 control-label" for="id">아이디</label>
					<div class="col-md-4">
						<input id="user-id" name="userid" type="text" placeholder="아이디"
							class="form-control input-md">
					</div>
				</div>

				<!-- Text input-->
				<div class="form-group ">
					<label class="col-md-4 control-label" for="name">이름</label>
					<div class="col-md-4">
						<input id="user-name" name="username" type="text" placeholder="이름"
							class="form-control input-md">
					</div>
				</div>

				<!-- Text input-->
				<div class="form-group">
					<label class="col-md-4 control-label" for="email">이메일</label>
					<div class="col-md-4">
						<input id="user-email" name="useremail" type="text"
							placeholder="Email address" class="form-control input-md">
						<span class="help-block"> * 임시 비밀번호가 이메일로 전송됩니다</span>
					</div>
				</div>

				<!-- Button (Double) -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="submit"></label>
					<div class="col-md-8">
						<button id="searchByInfo" name="submit" class="btn btn-success"
							type="submit">전송</button>
						<a href="/index.jsp" id="cancel" name="cancel"
							class="btn btn-danger">취소</a>
					</div>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/common/footer.jsp"%>
</body>
<script type="text/javascript">
</script>
</html>
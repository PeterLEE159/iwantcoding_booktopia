<%@page import="kr.go.booktopia.util.StringUtil"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String mode = (String) pageContext.getAttribute("mode");
	if (mode == null)
		mode = "guest";
%>
<html lang="ko">
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 책 상세정보</title>
</head>

<body>
	<div class="modal fade" id="login-form" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">로그인</h4>
				</div>
				<form action="/loginpage/logining.jsp">
					<div class="modal-body">

						<%
							String returnUrl = request.getParameter("returnUrl");
							if (returnUrl != null) {
						%>
						<input type="hidden" name="returnUrl" value="<%=returnUrl%>">
						<%
							}
						%>
						<div class="form-group">
							<label for="inputLoginId">아이디</label> <input class="form-control"
								name="inputLoginId" id="inputLoginId" type="text">
						</div>
						<div class="form-group">
							<label for="inputLoginId">비밀번호</label> <input
								class="form-control" name="inputLoginPwd" id="inputLoginPwd"
								type="password">
						</div>
						
						<div class="form-group text-center">
							<a href="/loginpage/searchid.jsp" class="login-form-options">아이디찾기</a>
							<a href="/loginpage/searchpwd.jsp" class="login-form-options">
								비밀번호 찾기</a> <a href="/loginpage/register.jsp" class="login-form-options"> 회원가입</a>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-default btn-block">로그인</button>
						<a href="/index.jsp" class="btn btn-default btn-block" data-dismiss="modal">취소</a>
					</div>
				</form>

			</div>
		</div>
	</div>
	<script>
		function alertt() {
			alert('아이디 혹은 비밀번호를 확인해주세요.');
			$("#login-form").modal();
			return;
		}
	</script>
	<%
		if (request.getParameter("fail") != null) {
	%>
	<script>
	
		alertt();
	</script>

	<%
		}
		boolean isLogined = false;
		User user = null;
		session = request.getSession(false);
		if (session != null) {
			user = (User) session.getAttribute("userInfo");
			if (user != null) {
				isLogined = true;
			}
		}
	%>


	<nav class="navbar navbar-default">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/index.jsp"> <img alt=""
					src="/images/logo04.png" width="150px;">
				</a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="/search/searchbook.jsp"><i
						class="fa fa-search fa-fw"></i> 자료검색</a></li>
				<li><a href="/openboard/notice/list.jsp"><i
						class="fa fa-question-circle fa-fw"></i> 열린마당</a></li>
				<li><a href="/mypage/borrow/borrow.jsp"><i
						class="fa fa-book fa-fw"></i> 내서재</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">

				<%
					if (isLogined) {
				%>
				<li><a><%=user.getName()%>님 환영합니다.</a></li>
				<li><a href="/loginpage/logout.jsp"><i
						class="fa fa-sign-out fa-fw"></i> 로그아웃</a></li>
				<%
					if (user != null && "Y".equals(user.getCharIsAdmin())) {
				%>
				<li><a href="/adminpage/book/addbooklist.jsp"><i
						class="fa fa-pie-chart fa-fw"></i> 관리자페이지</a></li>
				<%
					}
				%>
				<%
					} else {
				%>
				<li><a href="#" data-toggle="modal" data-target="#login-form"><i
						class="fa fa-sign-in fa-fw"></i> 로그인</a></li>
				<li><a
					href="/loginpage/register.jsp?returnUrl=<%=StringUtil.isEmpty(returnUrl) ? "/index.jsp" : returnUrl%>"><i
						class="fa fa-user-plus fa-fw"></i> 회원가입</a></li>
				<%
					}
				%>
				<!--          <li><a href="#"><i class="fa fa-sign-out fa-fw"></i> 로그아웃</a></li> -->
			</ul>


		</div>
		<!-- /.container-fluid -->
	</nav>


</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 질문하기</title>
</head>
<body> 
<% pageContext.setAttribute("sideMode", "qa"); %>     
<% pageContext.setAttribute("url","/openboard/qna/form.jsp"); %>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<div class="container">
<%
	
%>
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/board-side.jsp" %>
		</div>
		
		<div class="col-sm-7 contents">
			<h3 class="well">질문 올리기</h3>
			<form class="well" method="post" action="add.jsp">
				<div class="form-group">
					<label>제목</label>
					<input type="text" class="form-control" name="title" id="title"/>
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea rows="10" class="form-control" name="content" id="content"></textarea>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-info btn-sm" id="submit-btn">작성완료</button>
					<a href="list.jsp" class="btn btn-warning btn-sm">취소</a>
				</div>
			</form>			
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
	document.getElementById("submit-btn").addEventListener("click", function(event) {
		
		var title = document.getElementById("title").value;
		var content = document.getElementById("content").value;
		
		if (title == "" || content == "") {
			event.preventDefault();
			alert("제목 또는 내용을 모두 입력해 주세요.");
			
		}
		
	})
</script>
</html>
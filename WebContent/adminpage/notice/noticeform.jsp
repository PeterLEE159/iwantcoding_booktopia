<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 공지사항 등록</title>
</head>
<body>
<% pageContext.setAttribute("url","/index.jsp");
pageContext.setAttribute("sideMode", "notice");%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>			
		<div class="col-sm-7 contents">
			<h3 class="well">공지/새소식 등록</h3>	
			<form class="well" method="post" action="noticeadd.jsp">
				<div class="form-group">				

                    <div class="radio">
                        <label><input type="radio" name="emergency" value="Y" >공지글</label>
                        <label><input type="radio" name="emergency" value="N" >일반글</label>
                  </div>
				</div>
				
				<div class="form-group">
					<label>제목</label>
					<input id="title" type="text" class="form-control" name="title" value="" />
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea id="content" rows="10" class="form-control" name="contents"></textarea>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-info btn-sm" id="submit-btn">작성완료</button>
					<a href="/adminpage/book/addbooklist.jsp" class="btn btn-warning btn-sm">취소</a>
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
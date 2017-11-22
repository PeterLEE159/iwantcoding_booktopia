<%@page import="kr.go.booktopia.vo.Question"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 질문수정하기</title>
</head>
<body>
<% pageContext.setAttribute("sideMode", "qa"); %>
<%@ include file="/common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/board-side.jsp" %>
		</div>			
		
		<%
			int id = Integer.parseInt(request.getParameter("id"));
		
			DaoManager daoManager = DaoManager.getInstance();
			Question question = daoManager.read(Question.class, id);
			
		%>
		
		<div class="col-sm-7 contents">
			<h3 class="well">질문 수정하기</h3>
			<form class="well" method="post" action="rewriteupdate.jsp">
				<input type="hidden" name="id" value=<%=question.getId()%>>
				<div class="form-group">
					<label>제목</label>
					<input type="text" class="form-control" name="title" value="<%=question.getTitle() %>" />
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea rows="10" class="form-control" name="content"><%=question.getContent() %></textarea>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-info btn-sm">작성완료</button>
					<a href="list.jsp" class="btn btn-warning btn-sm">취소</a>
				</div>
			</form>			
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>
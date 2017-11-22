<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.Genre"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서검색</title>
</head>
<body>
	<%@ include file="/common/navbar.jsp"%>

	<div class="container text-center">
		<h1 style="color: #82ba44;">자료 검색</h1>
	</div>
	<div class="container">
		<%
			List<Genre> genreList = DaoManager.getInstance().list(Genre.class, null);
		%>
		<div class="genre-selector">
			<%
				for (Genre genre : genreList) {
			%>
			<div class="col-md-3">
				<input type="checkbox" id="genre-<%=genre.getId()%>">
				<%=genre.getType()%>
			</div>
			<%
				}
			%>
		</div>
		<hr class="colorgraph">
		<div>
			<div class="col-md-2">
				<select id="select-book-search-opt" class="form-control">
					<option>제목</option>
					<option>저자</option>
					<option>출판사</option>
				</select>
			</div>
			<div class="col-md-8">
				<input id="input-book-search" type="text" class="form-control">
			</div>
			<div class="col-me-2">
				<a id="a-book-search" class="btn btn-primary">검색</a>
			</div>
		</div>
		<hr class="colorgraph">
		<div class="row text-center">
			<p>검색하신 조건의 검색결과가 없습니다.</p>
			<a href="#" class="btn btn-primary">희망도서 신청하기</a>
		</div>
	</div>
	<%@ include file="/common/footer.jsp"%>
</body>
</html>
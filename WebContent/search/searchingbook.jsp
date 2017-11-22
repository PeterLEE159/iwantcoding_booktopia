<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서 검색</title>
</head>
<body>
	<%@ include file="/common/navbar.jsp"%>
	<div class="container text-center">
		<h1 style="color: #82ba44;">자료 검색</h1>
	</div>

	<div class="container">

		<%@ include file="/common/customer_book_search.jsp"%>
		<hr class="colorgraph">
		<div class="row">
			<ul class="booklist">
				<li>
					<div>
						<input type="checkbox"> <img
							src="/images/15012323206700.jpg" style="width: 100px;">
					</div>
					<dl>
						<dt>
							<a href="">펭귄의 사생활</a>
						</dt>
						<dd>저자: 와타나베 유키</dd>
						<dd>역자: 윤재</dd>
						<dd>출판사: 문학동네</dd>
						<dd>발행년: 2017</dd>
						<dd>자료상태: 대출중</dd>
					</dl>
				</li>
				<li>
					<div>
						<input type="checkbox"> <img
							src="/images/15012323206700.jpg" style="width: 100px;">
					</div>
					<dl>
						<dt>
							<a href="">펭귄의 사생활</a>
						</dt>
						<dd>저자: 와타나베 유키</dd>
						<dd>역자: 윤재</dd>
						<dd>출판사: 문학동네</dd>
						<dd>발행년: 2017</dd>
						<dd>자료상태: 대출중</dd>
					</dl>
				</li>
			</ul>
		</div>
		<div class="text-center">
			<a href="" class="btn btn-success canc">예약하기</a>
		</div>
	</div>
	<%@ include file="/common/footer.jsp"%>
</body>
</html>
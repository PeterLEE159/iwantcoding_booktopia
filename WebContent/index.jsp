<%@page import="kr.go.booktopia.dao.AnnouncementDao"%>
<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.vo.Book"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/maps/documentation/javascript/demos/demos.css">
<title>북토피아: 메인화면</title>
</head>
<body>  
<%@ include file="/common/navbar.jsp" %>
<%
	Criteria c = new Criteria();
	c.setSearchRange(5);
	c.setPage(1);
	
	List<Book> rentalList = new BookDao().readByRentalCount(c);
	List<Book> latestList = new BookDao().readLatestBook(c);
%>
<div class="back" style="background: #333;">
	<div class="container">
		
		<div class="row pobook main top-buffer">
			<h2>도서 검색</h2>
			<div class="row">	
				<form action="/search/searchbook.jsp" method="get">
					<div class="col-md-2">
						<select name="opt" class="form-control">
							<option>제목</option>
							<option>저자</option>
							<option>출판사</option>
						</select>
					</div>
					<div class="col-md-7">
						<input name="keyword" type="text" class="form-control">
					</div>
					<div class="col-md-1">
						<button type="submit" class="btn btn-primary btn-block">검색</button>
					</div>
				</form>
			</div>
		</div>
			
		<div class="row main pobook top-buffer">	
			<h2>인기 도서</h2>
			<div class="btn-group" role="group">
			  	<button onclick="alignBook(0)" class="btn btn-default btn-sm"><i class="fa fa-book fa-fw"></i>대여순</button>
				<button onclick="alignBook(1)" class="btn btn-default btn-sm"><i class="fa fa-thumbs-up fa-fw"></i>추천순</button>
			</div>
			
			<ul id="simple-book" class="top-buffer">
				<% for(Book book : rentalList) { %>
				<li class="animated fadeIn" onclick="bookDetail(<%=book.getId()%>)">
					<img src="<%=book.getFullImageUrl()%>">
					<h4><%=book.getName() %><small class="white-text pull-right"><%=book.getWriter().getName() %> 저</small></h4>
					<p><%=book.getPublisher().getName() %></p>				
				</li>
				<% } %>
			</ul>				
		</div>
		
	</div>
</div>

<%
	Criteria annCriteria = new Criteria();
	annCriteria.setBeginIndex(1);
	annCriteria.setEndIndex(2);

	AnnouncementDao announcementDao = new AnnouncementDao();

	List<Announcement> notices = announcementDao.getNotices(annCriteria);
%>

<div class="container">
	<div class="row">
		<div class="col-md-8 notice" >
			<h2><a href="/openboard/notice/list.jsp">공지사항</a>
			<a href="/openboard/notice/list.jsp"><span class="btn btn-primary btn-xs pull-right">더보기</span></a></h2>
			<div>
				<ul>
					<% for (Announcement announcement : notices) { %>
					<li>
						<span class="glyphicon glyphicon-volume-up"></span>
						<a href="/openboard/notice/detail.jsp?id=<%=announcement.getId()%>"><%=announcement.getTitle() %></a>
						<span class="pull-right"><%=announcement.getSimpleCreatedAt() %></span>
					</li>
					<%} %>							
				</ul>					
			</div>
		</div>
		<div class="col-md-2 col-md-offset-1 text-left" id="util">
			<a href="/mypage/wish/wishbook.jsp" class="btn btn-primary">희망 도서 신청</a><br><br>
			<a href="/mypage/borrow/borrow.jsp"  class="btn btn-success">대출 도서 조회</a>
		</div>				
	</div>
	<div class="row pobook top-buffer">	
			<h2>신간 도서</h2>
			<ul>
				<% for(Book book : latestList) { %>
				<li class="animated fadeIn" onclick="bookDetail(<%=book.getId()%>)">
					<img src="<%=book.getFullImageUrl()%>">
					<h4><%=book.getName() %><small class="pull-right"><%=book.getWriter().getName() %> 저</small></h4>
					<p><%=book.getPublisher().getName() %></p>							
				</li>
				<% } %>
			</ul>				
	</div>
</div>
<section id="section-intro" class="wow fadeIn">
	<div class="container">
		<div class="row">
			<div class="col-md-4">
				<img class="img-responsive" src="/images/lap-booktopia.png">
			</div>
			<div class="col-md-8">
				<h4 style="margin-top: 42px;">사이트에서 책을 예약하거나 미리보를 통해 보다 쉽게 도서관에 접근할 수 있습니다 !</h4>
				<h4>문의사항이 있으신분들은 질문답변 게시판을 참고해주시고 관리자에게 연락 부탁드립니다</h4>
			</div>
		</div>
	</div>
</section>
<section id="section-enquire">
	<div class="row">
		<div class="col-md-4 col-md-offset-1 wow fadeInLeft">
			<div id="map"></div>
		</div>
		<div class="col-md-5 col-md-offset-1 wow fadeInRight">
			<h3 class="page-header">문의하기</h3>
			<form>
				<div class="form-group">
					<input type="email" class="form-control" placeholder="이메일" required>
				</div>
				<div class="form-group">
					<input type="text" placeholder="제목" class="form-control">
				</div>
				<div class="form-group">
					<textarea rows="5" placeholder="문의내용" class="form-control"></textarea>
				</div>
				<button type="submit" class="btn btn-primary"><i class="fa fa-pencil fa-fw"></i>문의하기</button>
			</form>
		</div>
	</div>
</section>


<%@ include file="/common/footer.jsp" %>
</body>
<script>
	function initMap() {
	  var seoul = {lat: 37.572881, lng: 126.9898893};
	  var map = new google.maps.Map(document.getElementById('map'), {
	    zoom: 16,
	    center: seoul
	  });
	  var marker = new google.maps.Marker({
	    position: seoul,
	    map: map
	  });
	  map.setOptions({draggable: false});
  }

	function bookDetail(bookId) {
		window.location.href = "/book/detail.jsp?id="+bookId+"&returnUrl=/index.jsp";
	}
	
	function alignBook(mode) {
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				var books = JSON.parse(xhr.responseText);
				var body = document.getElementById('simple-book');
				var htmlContent = '';
				books.map(function(book) {
					htmlContent += "<li class='animated fadeIn' onclick='bookDetail("+book.id+")'>";
					htmlContent += "<img src='"+book.fullImageUrl+"'>";
					htmlContent += "<h4>"+book.name+"<small class='pull-right'>"+book.writer.name+" 저</small></h4>";
					htmlContent += "<p>"+book.publisher.name+"</p>";							
					htmlContent += "</li>";
				});
				if(htmlContent != '')
					body.innerHTML = htmlContent;
			}
		};
		
		xhr.open('GET', '/read.bookByCriteria?mode='+mode);
		xhr.send(null);
		
	}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDNpuB1xYE0YGvnADInd_oZGj62v73c7jo&callback=initMap" type="text/javascript"></script>
</html>

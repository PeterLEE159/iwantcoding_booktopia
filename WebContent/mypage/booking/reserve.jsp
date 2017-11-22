<%@page import="kr.go.booktopia.vo.PagingCriteria"%>
<%@page import="kr.go.booktopia.util.DateUtil"%>
<%@page import="kr.go.booktopia.vo.BookBooking"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.dao.BookingDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서 예약</title>
</head>
<body>
<% 
	pageContext.setAttribute("url","/mypage/booking/reserve.jsp"); 
	pageContext.setAttribute("sideMode", "booking");
%>

<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<%
	final int rowsPerPage = 5;
	final int naviPerPage = 5;
	
	int p = 1;
	try {
		p = Integer.parseInt(request.getParameter("p"));
	} catch (NumberFormatException e) {}
	
	BookingDao bookingDao = new BookingDao();
	
	int totalRows = bookingDao.bookingCountById(user.getId());	
	int totalPages = (int) Math.ceil(totalRows/(double)rowsPerPage);	
	
	if (p < 1) {
		p = 1;
	} else if (p > totalPages && totalPages != 0) {
		p = totalPages;
	} else if (totalPages == 0) {
		p = 1;
	}
	
	
	int totalNaviBlocks = (int) Math.ceil(totalPages/(double)naviPerPage);
	int currentNaviBlock = (int) Math.ceil(p/(double)naviPerPage);
	
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	
	if (currentNaviBlock == totalNaviBlocks) {
		endPage = totalPages;
	}
	
	
	int beginIndex = (p - 1) * rowsPerPage + 1;
	int endIndex = p * rowsPerPage;
	
	PagingCriteria pagingCriteria = new PagingCriteria();
	pagingCriteria.setUserId(user.getId());
	pagingCriteria.setBeginIndex(beginIndex);
	pagingCriteria.setEndIndex(endIndex);

%>

<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/mypage-side.jsp" %>
		</div>		
		<div class="col-sm-7 contents">
			<div class="row deser">
				<h3>예약 내역</h3>
				<p>예약 도서 권수 : <%=totalRows %>권</p>
			</div>
			<div class="row">
				<ul class="booklist">
					<%
						List<BookBooking> bookBookings = bookingDao.getBookingPagingById(pagingCriteria);
					
						for (BookBooking booking : bookBookings) {
					%>
					<li>
						<div>
							<input type="checkbox" class="booking-<%=booking.getId() %>">				
							<img src="<%=booking.getBook().getFullImageUrl() %>" width="100px;">
						</div>
						<dl>
							<dt><a href="/book/detail.jsp?id=<%=booking.getBook().getId() %>"><%=booking.getBook().getName() %></a></dt>
							<dd>저자: <%=booking.getBook().getWriter().getName() %></dd>
							<% if (booking.getBook().getTranslator() != null) { %>
							<dd>역자: <%=booking.getBook().getTranslator().getName() %></dd>
							<% } %>							
							<dd>출판사: <%=booking.getBook().getPublisher().getName() %></dd>
							<dd>발행년: <%=DateUtil.yyyy(booking.getBook().getPublishDate()) %></dd>
							<dd>자료상태: <%=booking.getBook().getRentalFormat() %></dd>
						</dl>
					</li>
					<%
						}
					%>					
				</ul>				
			</div>
			<div class="panel-body text-center">
					<ul class="pagination">
						<li><a href="/mypage/booking/reserve.jsp?p=<%=p-1 %>">&lt;</a></li>
					<%
						for (int i=beginPage; i<=endPage; i++) {					
					%>
						<li class=<%=p==i ?  "active" : ""  %>><a href="/mypage/booking/reserve.jsp?p=<%=i %>" ><%=i %></a></li>
					<%		
						}
					%>
						<li><a href="/mypage/booking/reserve.jsp?p=<%=p+1 %>">&gt;</a></li>
					</ul>
			</div>
			<div class="text-center">
				<button id="btn-cancel" class="btn btn-danger canc">예약취소</button>			
			</div>
		</div>
	</div>				
</div>
<%@ include file="/common/footer.jsp" %>

</body>
<script>
	document.getElementById('btn-cancel').addEventListener('click', function(event) {
		var checkboxes = document.querySelectorAll('ul input');		
		var ids = [];
		for(var i=0; i<checkboxes.length; i++) {
			var checkbox = checkboxes[i];
			var checkClass = checkbox.className;			
			if(checkbox.checked) {
				ids.push(checkClass.replace('booking-', ''));
			}
		}	
		ids = ids.toString();
		//console.log('체크버튼', ids);
		var url = 'do.booking-cancel?booking-id='+ids;			
		//console.log(url);
		
/* 			var params = {
			'booking-id': ids
		};
		url += encodeData(params); */
		
		if (ids != "") {
			window.location.href = url;
		} else {
			event.preventDefault();
			alert("취소할 도서를 선택해 주세요!");
		}
	})	
</script>
</html>
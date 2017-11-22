<%@page import="kr.go.booktopia.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.5.1/fullcalendar.min.css">

<title>북토피아: 책 예약하기</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	if(StringUtil.isEmpty(id))
		throw new ServletException("book id 를 전달해주세요");
	
	int bid = Integer.parseInt(id);
%>
<%@ include file="/common/navbar.jsp" %>
<input type="hidden" value=<%= bid %> id="ip-bookid">
<input type="hidden" value=<%= user != null ? user.getId() : 0 %> id="ip-userid">
<section id="section-calendar" class="animated fadeIn">
	<div class="row">
		<div class="col-md-5 col-md-offset-1 animated fadeInLeft">
			<div id='calendar'></div>
		</div>
		<div class="col-md-4 col-md-offset-1 animated fadeInRight">
			<h2 class="page-header">예약목록</h2>
			<table  class="table table-hover">
				<colgroup>
					<col width="25%">
					<col width="35%">
					<col width="35%">
					<col width="5%">
				</colgroup>
				<tr>
					<th>예약자 아이디</th>
					<th>예약 대여날짜</th>
					<th>예약 반납날짜</th>
					<th></th>
				</tr>
				<tbody id="table-booking-body">
				
				</tbody>
			</table>
		</div>
	</div>
	
	
</section>
<%@ include file="/common/footer.jsp" %>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/locale/ko.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.5.1/fullcalendar.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.5.1/locale/ko.js"></script>


<script>
var fullCalendarEventsArr = [];
$(document).ready(function() {
	$('#calendar').fullCalendar({
	    dayClick: function(clickDate) {
	    	
	    	var userId = document.getElementById('ip-userid').value;
	    	if(userId == 0) {
	    		alert('로그인을 먼저 해주세요');
	    		$('#login-form').modal();
	    		return;
	    	}
	    	
        	var formatDate = clickDate.format();
        	
        	
        	
        	var size = fullCalendarEventsArr.length;
        	
        	
        	for(var i =0 ; i< size; i++) {
        		date = new Date(formatDate);
        		var event = fullCalendarEventsArr[i];
        		var start = new Date(event.start);
        		var end = new Date(event.end);
        		
        		if(date >= start && date <= end) {
        			alert('해당 도서는 이미 예약이 되어 있습니다');
        			return;
        		}
        		
        		var sevenAfter = new Date(date.setDate(date.getDate() + 7));
        		if(sevenAfter >= start && sevenAfter <= end) {
        			alert('예약예정일 중 다른 예약일과 겹칩니다');
        			return;
        		}
        	}
        	
        	var check = confirm(formatDate+' 부터 도서를 예약하시겠습니까?');
        	if(check) {
	        	var bookId = document.getElementById('ip-bookid').value;
	        	
	        	var xhr = new XMLHttpRequest();
	        	xhr.onload = function() {
	        		if(xhr.status == 200) {
	        			var location = window.location.href;
	        			window.location.href = location;
	        		}
	        	}
	        	xhr.open('POST', '/do.create_booking');
	        	xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
	    		xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
	    		xhr.setRequestHeader("Pragma","no-cache");
	        	xhr.send("userid="+userId+"&bookid="+bookId+"&date="+(clickDate.format()));
        	}
        	
    	}
		
	});
	function addClassByDate(date) {
	    var dataAttr = getDataAttr(date);
	    var tag = $("[data-date='" + dataAttr + "']");
	    tag.addClass("hasEvent");
	}

	function getDataAttr(date) {
	    return date.getFullYear() + "-" + ((date.getMonth() + 1) < 10 ? '0' : '') + (date.getMonth()+1) + "-" + (date.getDate().toString().length === 2 ? date.getDate() : "0" + date.getDate());
	};
	
	function bookingHover(startDate) {
		console.log(startDate);
	}
	
	function requestMonth(requestDate) {
		
		var bid = document.getElementById('ip-bookid').value;
		var url = '/do.bookbookingbymonth?date='+requestDate+'&id='+bid;
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				
				var bookings = JSON.parse(xhr.responseText);
				
				var size = bookings.length;
				
				var body = document.getElementById('table-booking-body');
				var htmlContent = '';
				var userId = document.getElementById('ip-userid').value;
				for(var i=0; i< size; i++) {
					var booking = bookings[i];
					var book = booking.book;
					
					htmlContent += "<tr>";
					htmlContent += "	<td>"+booking.uuid+"</td>";
					htmlContent += "	<td>"+booking.formatBookingDate+"</td>";
					htmlContent += "	<td>"+booking.formatReturnDate+"</td>";
					htmlContent += "	<td>"+(booking.userId == userId ? "<img src='/images/my_booking.png'>" : "")+"</td>";
					htmlContent += "</tr>";
					
					fullCalendarEventsArr.push({
						title: book.name,
						start: booking.formatBookingDate,
						end: booking.formatReturnDate
					});
					
				}
				
				body.innerHTML = htmlContent;
				
				$('#calendar').fullCalendar({
				    events: fullCalendarEventsArr
				});
				
				
				for (var i = 0; i < fullCalendarEventsArr.length; i++) {
				    var evStartDate = new Date(fullCalendarEventsArr[i].start);
				    var evFinishDate = new Date(fullCalendarEventsArr[i].end);
				    
				    if (fullCalendarEventsArr[i].end) {
				        while (evStartDate <= evFinishDate) {
				            addClassByDate(evStartDate);
				            evStartDate.setDate(evStartDate.getDate() + 1);
				    
				        }
				    
				    } else {
				        addClassByDate(evStartDate);
				    }
				}
				
			}
		}
		xhr.open('GET', url);
		xhr.send(null);
	}
	
	
	var date = new Date();
	requestMonth(date.getFullYear() +'-'+ (date.getMonth() + 1) +'-'+ date.getDate());
	
	
	document.getElementsByClassName('fc-prev-button')[0].addEventListener('click', function() {
		var date = $('#calendar').fullCalendar('getDate');
		date = date.format();
		date = date.substring(0, 10);
		requestMonth(date);
	});
	
	document.getElementsByClassName('fc-next-button')[0].addEventListener('click', function() {
		var date = $('#calendar').fullCalendar('getDate');
		date = date.format();
		date = date.substring(0, 10);
		requestMonth(date);
	});
})
</script>
</html>
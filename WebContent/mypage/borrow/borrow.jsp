<%@page import="kr.go.booktopia.vo.PagingCriteria"%>
<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.vo.BookRental"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서 대출</title>
</head>
<body>

<% 
	pageContext.setAttribute("url","/mypage/borrow/borrow.jsp");
	pageContext.setAttribute("sideMode", "rental");
%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL.jsp" %>
<%
	String lendType = request.getParameter("type");
	if (lendType == null) {
		lendType = "R";
	}
	
	int p = 1;
	try {
		p = Integer.parseInt(request.getParameter("p"));
	} catch (NumberFormatException e) {}
	
	final int rowsPerPage = 10;
	final int naviPerPage = 5;
	
	BookDao bookDao = new BookDao();
	
	PagingCriteria pagingCriteria = new PagingCriteria();
	pagingCriteria.setType(lendType);
	pagingCriteria.setUserId(user.getId());
	
	int totalRows = bookDao.countById(pagingCriteria);	
	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	
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
	
	pagingCriteria.setBeginIndex(beginIndex);
	pagingCriteria.setEndIndex(endIndex);
	
	List<BookRental> bookRentals = bookDao.getBoardPagingById(pagingCriteria);
%>
<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/mypage-side.jsp" %>
		</div>	
		<div class="col-sm-8 contents">
			<div class="row deser" id="borrowdiv">
				<h3>대출 도서 현황</h3>
				<p id="book-count">대출 도서 권수 : <%=totalRows %>권</p>	
				<button class="
					<%
						if(lendType.equals("R")) {
					%>
							btn btn-default active
					<%
						} else {
					%>						
							 btn btn-default
					<%
						}
					%>
					">대출중인도서</button>
				<button class="
					<%
						if(lendType.equals("N")) {
					%>
							btn btn-default active
					<%
						} else {
					%>						
							 btn btn-default
					<%
						}
					%>
					">이전대출도서</button>				
			</div>
			<div class="row">
				<div class="panel panel-default">
					<table class="table table-hover">
						<colgroup>
							<col width="8%">
							<col width="18%">
							<col width="18%">
							<col width="18%">
							<col width="14%">
							<col width="14%">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>도서명</th>
								<th>대출일</th>
								<th id ="table-th">
									<%
										if (lendType.equals("R")) {										
									%>
										반납예정일
									<%
										} else {
									%>
										반납완료일
									<%
										}
									%>																	
								</th>
								<th>연체일수</th>
								<th>연기횟수</th>
								<th>반납연기</th>
							</tr>
						</thead>
						<tbody id="rental-body">						
							<%														
								for (BookRental bookRental : bookRentals) {			 					
							%>
							 		<tr class="book_tr">
										<td><%=bookRental.getId() %></td>
										<td><%=bookRental.getBook().getName() %></td>
										<td><%=bookRental.yyyymmdd(bookRental.getRentalDate()) %></td>
										<td><%=bookRental.yyyymmdd(bookRental.getExpectedReturnDate()) %></td>
										<td><%=bookRental.getDelayDate() %></td>
										<td><%=bookRental.getExtraDelayCount() %></td>
										<td><a href="delayUpdate.jsp?no=<%=bookRental.getId() %>&p=<%=p %>&type=<%=lendType %>" class="btn btn-primary btn-xs delay-button 
										<%
											if ("N".equals(lendType)) {
										%>
											disabled
										<%
											}
										%>
										">연기하기</a></td>
									</tr>
							<%									
								}							
							%>	 				
						</tbody>
					</table>
				</div>
				<div class="panel-body text-center">
					<ul class="pagination">
						<li><a href="/mypage/borrow/borrow.jsp?p=<%=p-1 %>&type=<%=lendType%>">&lt;</a></li>
					<%
						for (int i=beginPage; i<=endPage; i++) {					
					%>
						<li class=<%=p==i ?  "active" : ""  %>><a href="/mypage/borrow/borrow.jsp?p=<%=i %>&type=<%=lendType%>" ><%=i %></a></li>
					<%		
						}
					%>
						<li><a href="/mypage/borrow/borrow.jsp?p=<%=p+1 %>&type=<%=lendType%>">&gt;</a></li>
					</ul>
				</div>					
			</div>		
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
	/* function bookStateChange(p, type) {
		
	}
 */

 	document.querySelector("#borrowdiv p+button+button").addEventListener("click", function (event) {		
		
 		location.href="borrow.jsp?p=1&type=N";
 		
/* 		document.querySelector("#borrowdiv p+a").setAttribute('class', document.querySelector("#borrowdiv p+a").getAttribute('class').replace(' active', ''));
		
		atag2 = event.target;
		
		if (atag2.getAttribute('class').includes('active')) {
			return;
		} else {
			atag2.setAttribute('class', atag2.getAttribute('class')+' active');
		}	 */			
		
		
/* 		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var jsonText = xhr.responseText;
				var rentalList = JSON.parse(jsonText);
				
				var htmlContent = "";
				rentalList.forEach(function(rental, index) {
					htmlContent += "<tr>";
					htmlContent += "<td>"+rental.id+"</td>";
					htmlContent += "<td>"+rental.book.name+"</td>";
					htmlContent += "<td>"+rental.rentalDate+"</td>";
					htmlContent += "<td>"+rental.actualReturnDate+"</td>";
 					htmlContent += "<td>"+rental.delayDate+"</td>";
 					htmlContent += "<td>"+rental.extraDelayCount+"</td>";
 					htmlContent += "<td><button class='btn btn-primary btn-xs disabled'>연기하기</button></td>" 					
					htmlContent += "</tr>";					
				});
				
				document.getElementById('rental-body').innerHTML = htmlContent;
				
				var textContent = "반납완료일"
				document.getElementById('table-th').innerText = textContent;
				
				var cnt = document.getElementById('rental-body').getElementsByTagName('tr').length;
				document.getElementById('book-count').innerText = "이전 대출 권수 : "+cnt+"권"
			}
		};
		xhr.open("GET", "rentalbook.do");
		xhr.send(null); */
	});
	
	document.querySelector("#borrowdiv p+button").addEventListener("click", function (event) {		
		
		location.href="borrow.jsp?p=1&type=R";
		
/* 		document.querySelector("#borrowdiv p+a+a").setAttribute('class', document.querySelector("#borrowdiv p+a+a").getAttribute('class').replace(' active', ''));
		
		atag1 = event.target;
		
		if (atag1.getAttribute('class').includes('active')) {
			return;
		} else {
			atag1.setAttribute('class', atag1.getAttribute('class')+' active');
		}	 */
		
		
		/* var xhr = new XMLHttpRequest();		
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var jsonText = xhr.responseText;
				var rentalList = JSON.parse(jsonText);
				
				var htmlContent = "";
				rentalList.forEach(function(rental, index) {
					htmlContent += "<tr class='book_tr'>";
					htmlContent += "<td>"+rental.id+"</td>";
					htmlContent += "<td>"+rental.book.name+"</td>";
					htmlContent += "<td>"+rental.rentalDate+"</td>";
					htmlContent += "<td>"+rental.expectedReturnDate+"</td>";
 					htmlContent += "<td>"+rental.delayDate+"</td>";
 					htmlContent += "<td>"+rental.extraDelayCount+"</td>";
 					htmlContent += "<td><a href='delayUpdate.jsp?no="+rental.id+"'  class='btn btn-primary btn-xs delay-button'>연기하기</a></td>"; 					
					htmlContent += "</tr>";					
				});
				
				document.getElementById('rental-body').innerHTML = htmlContent;
				
				var textContent = "반납예정일"
				document.getElementById('table-th').innerText = textContent;
				
				var cnt = document.getElementById('rental-body').getElementsByTagName('tr').length;
				document.getElementById('book-count').innerText = "대출 도서 권수 : "+cnt+"권"
				
				var trs = document.querySelectorAll('tr.book_tr');
				var size = trs.length;
				for(var i=0; i< size; i++) {
					var tds = trs[i].getElementsByTagName('td');
					var delayDate = tds[5].innerText;
					
					if(delayDate >= 3) {
						var aTag = tds[6].getElementsByClassName('delay-button')[0];
						aTag.setAttribute('class', 'btn btn-primary btn-xs delay-button disabled');
					}
				}
				
			}
		};		
		xhr.open("GET", "rentalbook2.do");
		xhr.send(null); */
	});	

	var trs = document.querySelectorAll('tr.book_tr');
	var size = trs.length;
	for(var i=0; i< size; i++) {
		var tds = trs[i].getElementsByTagName('td');
		var delayDate = tds[5].innerText;
		
		if(delayDate >= 3) {
			var aTag = tds[6].getElementsByClassName('delay-button')[0];
			aTag.setAttribute('class', 'btn btn-primary btn-xs delay-button disabled');
		}
	}	
</script>
</html>>
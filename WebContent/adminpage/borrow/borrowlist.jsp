<%@page import="com.ibatis.sqlmap.engine.mapping.sql.dynamic.elements.IsNotNullTagHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.go.booktopia.vo.PagingCriteria"%>
<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="kr.go.booktopia.util.DateUtil"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.BookRental"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서 대출</title>
</head>
<body>    
<% pageContext.setAttribute("url","/index.jsp");
pageContext.setAttribute("sideMode", "rental");%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>

<%
String lendType = request.getParameter("type");
if (lendType == null) {
	lendType = "A";
}
// 현재 페이지 번호
	int p = 1;
	try {
		p = Integer.parseInt(request.getParameter("p"));
	} catch (NumberFormatException e) {}
	
	final int rowsPerPage = 10;
	final int naviPerPage = 5;
	
	DaoManager daoManager = DaoManager.getInstance();
	BookDao bookDao = new BookDao();

	
	PagingCriteria pagingCriteria = new PagingCriteria();
	pagingCriteria.setType(lendType);
	int totalRows = bookDao.count(pagingCriteria);
	
	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	// 전체 페이지 내비게이션 블록 개수 계산
	int totalNaviBlockCount = (int) Math.ceil(totalPages/(double) naviPerPage);
	// 현재 페이지 내비게이션 블록 번호 계산
	int currentBlockNo = (int) Math.ceil(p/(double) naviPerPage);
	// 페이지 내비게이션으로 표시할 시작 페이지 번호와 끝 페이지 번호 계산
	int beginPage = (currentBlockNo - 1) * naviPerPage + 1;
	int endPage = currentBlockNo * naviPerPage;
	if (currentBlockNo == totalNaviBlockCount) {
		endPage = totalPages;
	}
	
	// 현재 페이지 번호에 해당하는 데이터 조회에 사용할 시작 인덱스 계산
	int beginIndex = (p - 1) * rowsPerPage + 1;
	// 현재 페이지 번호에 해당하는 데이터 조회에 사용할 끝 인덱스 계산
	int endIndex = p * rowsPerPage;
	
	pagingCriteria.setBeginIndex(beginIndex);
	pagingCriteria.setEndIndex(endIndex);
	
	
	List<BookRental> bookRentals = bookDao.getBoardPagingByType(pagingCriteria);
	/* if ("A".equals(lendType)){ 
		bookRentals = daoManager.list(BookRental.class, new Criteria());
	} else if ("R".equals(lendType)) {
		bookRentals = bookDao.getRentalBoooks();
	} else if ("N".equals(lendType)) {
		bookRentals = bookDao.getNonRentalBoooks();
	} */

%>
<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		<div class="col-sm-7 contents">			
			<div class="row">
				<h3>대출 목록</h3>
				<p id="wholebook-num"> 조회결과 : 총<%=totalRows %>권</p>											
			</div>
			<div class="row">
				<form action="" method="get">
	         		<div class="row broption">
	         			<input type="radio" value="A" name="borrowoption" <%="A".equals(lendType)?"checked":"" %> onchange="bookStateChange(1, 'A')" > 전체대출목록
						<input type="radio" value="R" name="borrowoption" <%="R".equals(lendType)?"checked":"" %> onchange="bookStateChange(1, 'R')" > 대여중/연체
		            	<input type="radio" value="N" name="borrowoption" <%="N".equals(lendType)?"checked":"" %> onchange="bookStateChange(1, 'N')" >  반납
	         		</div>					
	         	</form>
			</div>					
			<div class="row">
				<div class="panel panel-default">
					<table class="table table-hover" id="rental-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>도서명</th>
								<th>대출일</th>
								<th>반납예정일</th>
								<th>회원이름</th>
								<th>상태</th>
<!-- 							<th>발송</th> -->
							</tr>
						</thead>
						<tbody id="rental-body">
						<%
							for (BookRental r : bookRentals ) {
						
						%>
								<tr>
									<td><%=r.getId() %></td>
									<td><%=r.getBook().getName() %></td>
									<td><%=DateUtil.yyyymmdd(r.getRentalDate()) %></td>
									<td><%=DateUtil.yyyymmdd(r.getExpectedReturnDate()) %></td>
									<td><%=r.getUser().getName() %></td>
									<td><%=r.rentalState()%></td> 
<!-- 								<td><button class="btn btn-success btn-xs">이메일 발송</button></td> -->
								</tr>
						<%
							}
						%>
						</tbody>
					</table>
				</div>			
				<div class="panel-body text-center">
					<ul class="pagination">
						<%
						if (p>1) {
						%>
						<li><a href="javascript:bookStateChange(<%=p-1 %>)">&lt;</a></li>
						<%	
						}
						
						for(int i=beginPage; i<=endPage; i++) {
						%>							
						<li class=<%=i==p ? "active" : "" %>><a href="javascript:bookStateChange(<%=i %>)"><%=i %></a></li>
						<%
						}
						if (p<totalPages) {
						%>
						
						<li><a href="javascript:bookStateChange(<%=p+1 %>)">&gt;</a></li>
						<%
						}
						%>
					</ul>
				</div>					
			</div>		
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
	function bookStateChange(p, type) {
		type = type || document.querySelector("input[type='radio']:checked").value;
		
		location.href="borrowlist.jsp?p=" + p + "&type=" + type;
	}

	/* function bookStateChange(p, type) {
		type = type || document.querySelector("input[type='radio']:checked").value;
		
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var jsonText = xhr.responseText;
				var rentalList = JSON.parse(jsonText);
				//console.log(rentalList);
				
				
				var htmlContent = "";
				rentalList.forEach(function(rental, index) {
					var str = "";
					
					console.log(rental.actualReturnDate);
					if(!rental.actualReturnDate) {
						if (rental.delayDate > 0) {
							str = "연체중";
						} else {
							str = "대여중";
						}
					} else {
						str = "반납완료";	
					}
					
					htmlContent += "<tr>";
					htmlContent += "<td>"+rental.id+"</td>";
					htmlContent += "<td>"+rental.book.name+"</td>";
					htmlContent += "<td>"+rental.rentalDate+"</td>";
					htmlContent += "<td>"+rental.expectedReturnDate+"</td>";
 					htmlContent += "<td>"+rental.user.id+"</td>"; 					
 					htmlContent += "<td>"+str+"</td>";
 					htmlContent += "<td><button class='btn btn-success btn-xs'>이메일발송</button></td>"
					htmlContent += "</tr>";
					
					
					
				});
						
				document.getElementById('rental-body').innerHTML = htmlContent;

				var btnNodeList = document.querySelectorAll("#rental-body .btn");
				for (var i=0; i<btnNodeList.length; i++) {
					var btn = btnNodeList.item(i);
					btn.addEventListener('click', function(event) {
						var user = event.target.parentNode.previousElementSibling.previousElementSibling.innerText;
						alert(userId);
						
						
					})
				}
				
				var cnt = document.getElementById('rental-body').getElementsByTagName('tr').length;
				document.getElementById('wholebook-num').innerText = "조회 결과:총"+cnt+"권";
			}
			
		};
		
		xhr.open("GET", "lendbook.do?type="+type + "&p=" + p);
		xhr.send(null);
		
	} */
	
</script>
</html>
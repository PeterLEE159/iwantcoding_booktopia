<%@page import="kr.go.booktopia.dao.BookRentalDao"%>
<%@page import="kr.go.booktopia.vo.BookRental"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.web.BookSearchServlet"%>
<%@page import="kr.go.booktopia.vo.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서 목록</title>
</head>
<body>    
<% pageContext.setAttribute("url","/index.jsp");
pageContext.setAttribute("sideMode", "addBook");%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>

<%
	int rows = 10;
	try {
		rows = Integer.parseInt(request.getParameter("rows"));
	} catch(NumberFormatException e) {}
	
	int p = 1;
	try {
		p = Integer.parseInt(request.getParameter("p"));
	} catch (NumberFormatException e) {}
	
	String opt = request.getParameter("opt");
	String keyword = request.getParameter("keyword");
	
	final int rowsPerPage = rows;
	final int naviPerPage = 5;
	
	int beginIndex = (p - 1) * rowsPerPage + 1;
	int endIndex = p * rowsPerPage;
	
	Criteria criteria = new Criteria();
	if (opt !=null && !opt.isEmpty()) {
		criteria.setOpt(opt);
	}
	if (keyword != null && !keyword.isEmpty()) {
		criteria.setKeyword(keyword);
	}
	criteria.setBeginIndex(beginIndex);
	criteria.setEndIndex(endIndex);
	
	BookDao bookDao = new BookDao();
	int totalRows = bookDao.getTotalRows(criteria);
	
	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	int totalNaviBlocks = (int) Math.ceil(totalPages/(double) naviPerPage);
	int currentNaviBlock = (int) Math.ceil(p/(double) naviPerPage);
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	if (currentNaviBlock == totalNaviBlocks) {
		endPage = totalPages;
	}
	
	List<Book> books = bookDao.getBooks(criteria);

	
	for (Book book : books) {
		BookRentalDao bookRentalDao = new BookRentalDao();
		BookRental lastestBookRental =  bookRentalDao.latestBookRental(book.getId());
		 
		book.setLastestBookRental(lastestBookRental);
	
	}
	
%>

<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		<div class="col-sm-9 contents">			
			<h3>도서 목록</h3>
			<hr class="colorgraph">							
			<div class="row">
				<div class="form-group">
					<div>
						<form id="search-form" class="form-inline" method="get" action="addbooklist.jsp" >	
							<input type="hidden" name="p" id="p-field" value="<%=p %>" />
							<input type="hidden" name="rows" id="rows-field" value="<%=rows %>" />		
							<div class="form-group">
			            		<label for="opt" class="sr-only">옵션</label>
			                	<select class="form-control input-sm" id="opt" name="opt">
		               				<option value="name" <%="name".equals(opt)?"selected":"" %>> 도서이름</option>
	   								<option value="writer" <%="writer".equals(opt)?"selected":"" %>> 저자</option>
	   								<option value="publisher" <%="publisher".equals(opt)?"selected":"" %>> 출판사</option>
			               		</select>
	         				</div>
			            	<div class="form-group">
			            		<label for="keyword"  class="sr-only">keyword</label>
			               		<input type="text" class="form-control input-sm" id="keyword" name="keyword" value="<%=keyword != null?keyword:""%>">
			            	</div>
			               		<button type="submit" class="btn btn-primary btn-sm" onclick="search(event)">검색</button>
         				</form>
         			</div>
				</div>
			</div>
			<div class="row">
				<div class="panel panel-default">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>도서번호</th>
								<th>도서명</th>
								<th>저자</th>
								<th>출판사</th>
								<th>상태</th>
								<th>수정</th>
							</tr>
						</thead>
						<tbody>
						<% %>
						<%for(Book b : books) {%>
							<tr>
								<td><%=b.getId() %></td>
								<td><%=b.getName() %></td>
								<td><%=b.getWriter().getName() %></td>
								<td><%=b.getPublisher().getName() %></td>
								<%if (b.getLastestBookRental() == null) {%>
								<td><%=b.getRentalFormat()%></td>
								<%} else {%>
								<td><%=b.getLastestBookRental().rentalState()%></td>
								<%} %>
								<td><a href="/adminpage/book/updatebook.jsp?bno=<%=b.getId() %>" class="btn btn-success btn-xs">수정하기</a></td>
							</tr>
						<%} %>	
						</tbody>
					</table>
				</div>
				<a href="/adminpage/book/addbook.jsp" class="btn btn-primary pull-right">새 도서등록</a>
				
				<div class="panel-body text-center">
					<ul class="pagination input-sm">
					<%
					if (p>1) {
					%>
						<li><a href="javascript:goList(<%=p-1%>)">&lt;</a></li>
					<%
					}
					
					for (int i=beginPage; i<=endPage; i++) {
					%>
						<li class="<%=p==i?"active":""%>"><a href="javascript:goList(<%=i%>)"><%=i%></a></li>
					<%
					}
					
					if (p<totalPages) {
					%>
						<li><a href="javascript:goList(<%=p+1%>)">&gt;</a></li>
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
	function search(event) {
		event.preventDefault();
		document.getElementById("p-field").value = 1;
		document.getElementById("search-form").submit();
	}
	function goList(p) {
		document.getElementById("p-field").value = p;
		document.getElementById("search-form").submit();
	}
</script>
</html>
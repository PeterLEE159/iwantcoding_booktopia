<%@page import="kr.go.booktopia.util.StringUtil"%>
<%@page import="kr.go.booktopia.vo.WishCriteria"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.BookWish"%>

<%@page import="kr.go.booktopia.dao.BookwishDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 신청도서</title>
</head>
<body>    
<%	

	String strPage = request.getParameter("p");
	int p;
	if(strPage == null || strPage.isEmpty()) p = 1;
	else p = Integer.parseInt(strPage);

	String opt = request.getParameter("opt");
	String keyword = request.getParameter("keyword");
	
	final int rowsPerPage = 7;
	final int naviPerPage = 5;
	
	
	int beginIndex = (p - 1) * rowsPerPage + 1;
	int endIndex = p * rowsPerPage;
	
	WishCriteria c = new WishCriteria();
	if (opt != null && !opt.isEmpty()) {
		c.setOpt(opt);
	}
	if (keyword != null && !keyword.isEmpty()) {
		c.setKeyword(keyword);
	}
	c.setBeginIndex(beginIndex);
	c.setEndIndex(endIndex);
	
	BookwishDao dao = new BookwishDao();
	int totalRows = dao.getTotalRows(c);
	
	
	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	int totalNaviBlocks = (int) Math.ceil(totalPages/(double) naviPerPage);
	int currentNaviBlock = (int) Math.ceil(p/(double) naviPerPage);
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	if (currentNaviBlock == totalNaviBlocks) {
		endPage = totalPages;
	}	

	
	List<BookWish> BookWishs = dao.getBookWishs(c);

	
%>
<% pageContext.setAttribute("url","/index.jsp");
pageContext.setAttribute("sideMode", "adminWish");%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>
<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		<div class="col-sm-9 contents">			
			<div class="row">		
				<h3>희망도서 신청목록</h3>
				<hr class="colorgraph">
				<table class="table table-hover" >
					<thead>
						<tr>
							<th>번호</th>
							<th>신청자</th>
							<th>책이름</th>
							<th>저자</th>
							<th>출판사</th>
							<th>작성일</th>
							<th>처리상태</th>
						</tr>
					</thead>
					<tbody>
					<%for (BookWish e : BookWishs) { 
						boolean isAccepted = e.getAccepted().equals("Y");
					%>
						<tr>
							<td><%=e.getId()%></td>
							<td><%=e.getUser().getName() %></td>
							<td><%=e.getBookName() %></td>
							<td><%=e.getWriter() %></td>
							<td><%=e.getPublisher() %></td>
							<td><%=e.getSimpleCreatedAt() %></td>
<%-- 							<td><%=e.getAccepted() %></td> --%>
							<td><% if(e.getAccepted().equals("R")){ %>
								<input id="check-ok-btn-<%=e.getId() %>" class="btn btn-primary btn-xs"
								onclick="checkok(event, <%=e.getId()%>);" type="button" value="승인">
								<input id="check-no-btn-<%=e.getId() %>" class="btn btn-danger btn-xs"
								onclick="checkno(event, <%=e.getId()%>);" type="button" value="거부">
							<%}else {%>
								<input type="button" class="btn btn-xs <%=(isAccepted? "btn-primary" : "btn-danger")%>" value="<%= (isAccepted? "승인완료" : "거부완료")%>">
							<%}	%></td>
						</tr>
					<%} %>
					</tbody>
				</table>
			</div>	
			</div>
			<div class='text-center'>
				<form id='search-form'class='form-inline' action='adminwish.jsp' method='get'>
					<input type="hidden" name="p" id="p-field" value="<%=p %>" />
					<div class='form-group'>		
						<label for="opt" class='sr-only'>옵션</label>
							<select class='form-control input-sm' name='opt' id='opt'>
								<option value='bookname' <%="bookname".equals(opt)?"selected":"" %>> 책이름</option>
								<option value='username'<%="username".equals(opt)?"selected":"" %>> 신청자</option>
							</select>
					</div>
					<div class='form-group'>
						<label for="keyword"class='sr-only'>keyword</label>
						<input type='text' class='form-control input-sm' id="keyword"name='keyword' value='<%=keyword != null?keyword:""%>' />
					</div>
						<button type='submit' class='btn btn-default btn-sm' onclick="search(event)">검색</button>
				</form>
				<div class="row text-center">
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
<%@ include file="/common/footer.jsp" %>
<script type="text/javascript">
	
	function checkok(event,id) {
		var btn = event.target;
		var tr = btn.parentElement.parentElement;
		var td = tr.firstElementChild;
		var wishOkId = td.innerText;
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				document.getElementById("check-ok-btn-" +id).value ="승인완료";
				document.getElementById("check-no-btn-" +id).type = "hidden";
			}
		}
		xhr.open('GET','/adminpage/wish/wish_change.jsp?id=' +wishOkId);
		xhr.send(null);
	}
	function checkno(event,id) {
		var btn = event.target;
		var tr = btn.parentElement.parentElement;
		var td = tr.firstElementChild;
		var wishNoId = td.innerText;
		
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				document.getElementById("check-ok-btn-" +id).type ="hidden";
				document.getElementById("check-no-btn-" + id).value = "거부완료";
			}
		}
		xhr.open('GET','/adminpage/wish/wish_change2.jsp?id=' +wishNoId);
		xhr.send(null);
	}

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
</body>
</html>
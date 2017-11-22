<%@page import="kr.go.booktopia.util.DateUtil"%>
<%@page import="kr.go.booktopia.vo.BookRental"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="kr.go.booktopia.vo.PagingCriteria"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 회원 상세정보</title>
</head>
<body>    
<% 	pageContext.setAttribute("url","/index.jsp"); 
	pageContext.setAttribute("sideMode", "memberManage");
%>

<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>
<%

	int no = Integer.parseInt(request.getParameter("no"));
	DaoManager userDao = DaoManager.getInstance();
	User userinfo = userDao.read(User.class, no);

%>

<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		<div class="col-sm-9 contents">			
			<h3>회원 상세정보</h3> 
      		<hr>     
		      <table class="table table-bordered">
		         <tbody>
		            <tr>
		               <th>회원번호</th>
		               <td><%=userinfo.getId() %></td>            
		            </tr>
		            <tr>
		               <th>회원권한</th>
		               <td><% if(userinfo.getCharIsActive().equals("Y")){%>
		               정상
		               <% }else {%>
		               정지
		               <% } %></td>            
		            </tr>
		            <tr>
		               <th>아이디</th>
		               <td><%=userinfo.getUserId() %></td>            
		            </tr>
		            <tr>
		               <th>이름</th>
		               <td><%=userinfo.getName() %></td>            
		            </tr>
		            <tr>
		               <th>연락처</th>
		               <td><%=userinfo.getPhone() %></td>            
		            </tr>
		         </tbody>
		      </table>
      <!-- ------------------------------------------------------------------------------------- -->
      <%
      	String lendType = "A";
      	int p = 1;
	  	try {
	  		p = Integer.parseInt(request.getParameter("p"));
	  	} catch (NumberFormatException e) {}
	
	  	final int rowsPerPage = 7;
	  	final int naviPerPage = 10;
	  	
	  	int beginIndex = (p - 1) * rowsPerPage + 1;
	  	int endIndex = p * rowsPerPage;
	  	
	  	PagingCriteria c = new PagingCriteria();
	  	c.setType(lendType);
	  	c.setBeginIndex(beginIndex);
		c.setEndIndex(endIndex);
	  
	  	BookDao dao = new BookDao();
	  	int totalRows = dao.count(c);
	  	
	  	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	  	int totalNaviBlocks = (int) Math.ceil(totalPages/(double) naviPerPage);
	  	int currentNaviBlock = (int) Math.ceil(p/(double) naviPerPage);
	  	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	  	int endPage = currentNaviBlock * naviPerPage;
	  	if (currentNaviBlock == totalNaviBlocks) {
	  		endPage = totalPages;
	  	}
	  	
	  	c.setUserId(userinfo.getId());
	  	
	  	List<BookRental> bookRentals =dao.getRentalBookByUserId(c);
      	
      %> 
		      <h3>회원대출현황</h3>
		      <hr>
		      <div class="row">
		         <div class="panel panel-default">
		            <table class="table table-hover">
		               <thead>
		                  <tr>
		                     <th>번호</th>
		                     <th>도서명</th>
		                     <th>대출일</th>
		                     <th>반납예정일</th>
		                     <th>연체일수</th>
		                     <th>상태</th>
		                     <th>반납처리</th>
		                  </tr>
		               </thead>
		               <tbody> 
		               <%
		               		
		               		for(BookRental e : bookRentals) {
		               			boolean isReturned = e.getActualReturnDate() != null;	
		               %>
		                  <tr>
		                     <td><%=e.getId() %></td>
		                     <td><%=e.getBook().getName() %></td>
		                     <td><%=DateUtil.yyyymmdd(e.getRentalDate())%></td>
		                     <td><%=DateUtil.yyyymmdd(e.getExpectedReturnDate())%></td>
		                     <td><%=e.getDelayDate()%></td>
		                     <td id="return-state-<%=e.getId() %>"><%=e.rentalState()%></td>
		                     <td>
		                     	<input id="return-state-btn-<%=e.getId() %>" class="btn btn-xs <%=isReturned ? "btn-success" : "btn-danger"%>"
		                     	onclick="change(event, <%=e.getId() %>);" type="button" value="<%=isReturned ? "반납완료" : "반납처리"%>" id="btn">
		                     </td>
		                     
		                  </tr>
		                <%
		               		}
		                %>
		               </tbody>
		            </table>
		         </div>
		       
		         <%-- <div class="panel-body text-center">
		            <ul class="pagination">
		               <%
						if (p>1) {
						%>
							<li><a href="javascript:goList(<%=p-1%>)">prev</a></li>
						<%	
						}
						
						for (int i=beginPage; i<=endPage; i++) {
						%>
							<li class="<%=p==i?"active":""%>"><a href="javascript:goList(<%=i%>)"><%=i%></a></li>
						<%
						}
						if (p<totalPages) {
						%>
							<li><a href="javascript:goList(<%=p+1%>)">next</a></li>
						<%	
						}
						%>
		            </ul>		
     			</div>    --%>
  			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
	function change(event, id) {
		var btn = event.target;
		var tr = btn.parentElement.parentElement;
		var td = tr.firstElementChild;
		var rentalId = td.innerText;
		
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				document.getElementById("return-state-"+id).innerText = "반납완료";
				document.getElementById("return-state-btn-"+id).value = "반납완료";
				document.getElementById("return-state-btn-"+id).setAttribute("class", "btn btn-xs btn-success");
			}
		}
		xhr.open('GET', '/adminpage/user/book_return.jsp?id='+rentalId);
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
</html>>
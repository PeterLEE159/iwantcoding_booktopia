<%@page import="kr.go.booktopia.util.DateUtil"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.dao.UserDao"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 회원관리</title>
</head>
<body>    
<% pageContext.setAttribute("url","/index.jsp");
pageContext.setAttribute("sideMode", "memberManage");%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>
<% DaoManager m = DaoManager.getInstance();	%>

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
	
	UserDao userDao = new UserDao();
	int totalRows = userDao.getTotalRows(criteria);
	
	int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
	int totalNaviBlocks = (int) Math.ceil(totalPages/(double) naviPerPage);
	int currentNaviBlock = (int) Math.ceil(p/(double) naviPerPage);
	int beginPage = (currentNaviBlock - 1) * naviPerPage + 1;
	int endPage = currentNaviBlock * naviPerPage;
	if (currentNaviBlock == totalNaviBlocks) {
		endPage = totalPages;
	}
	
	List<User> users = userDao.getUsers(criteria);
	
%>

<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		<div class="col-sm-9 contents">			
			<h3>회원관리</h3>														
			<hr class="colorgraph">
			<div class="col-sm-7 contents">			
				<div class="row">
					<p id="wholebook-num"> 전체회원수 : <%=totalRows %>명</p>											
				</div>
			</div>
			
      		<div class="row">
         		<div class="form-group">
            		<div>
            			<form id="search-form" class="form-inline" method="get" action="membermanagement.jsp">
							<input type="hidden" name="p" id="p-field" value="<%=p %>" />
							<input type="hidden" name="rows" id="rows-field" value="<%=rows %>" />
							<div class="form-group">
	    						<label for="opt" class="sr-only">옵션</label>
	    						<select class="form-control input-sm" id="opt" name="opt">
	    							<option value="username" <%="username".equals(opt)?"selected":"" %>> 회원이름</option>
	    							<option value="userno" <%="userno".equals(opt)?"selected":"" %>> 회원번호</option>
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
      			<div>
					<div class="panel panel-default">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>회원번호</th>
									<th>회원이름</th>
									<th>연락처</th>
									<th>이메일</th>
									<th>등록일</th>
									<th>회원상태</th>
								</tr>
							</thead>
							<tbody id="rental-body">
							<%for (User u : users) {
								boolean isActive = u.getCharIsActive().equals("Y");
							%>
								<tr>
									<td><%=u.getId() %></td>
									<td><a href="/adminpage/user/memberdetail.jsp?no=<%=u.getId() %>"><%=u.getName() %></a></td>
									<td><%=u.getPhone() %></td>
									<td><%=u.getEmail() %></td>
									<td><%=DateUtil.yyyymmdd(u.getCreatedAt()) %></td>
									<td><% if(isActive){ %>
										<input id="change-ok-btn-<%=u.getId()%>" class=" btn btn-xs <%=isActive ? " btn-primary"  : "btn-danger" %>"
										 	onclick="change(event, <%=u.getId()%>);" type="button" value="<%=isActive ? "정상" : "정지"%>">
									<% } else { %>
										<input id="change-no-btn-<%=u.getId()%>" class=" btn btn-xs <%=isActive ? " btn-primary"  : "btn-danger" %>"
										 	onclick="changeRollback(event, <%=u.getId()%>);" type="button" value="<%=isActive ? "정상" : "정지"%>">
									<% } %>
									</td>
<%-- 									<td><input id="change-btn-<%=u.getId() %>" class=" btn btn-sm <%=isActive ? " btn-primary"  : "btn-danger" %>" --%>
<%-- 								onclick="change(event, <%=u.getId() %>);" type="button" value="<%=isActive ? "정상" : "정지"%>"> </td> --%>
									
								</tr>
							<%} %>
							</tbody>
						</table>
					</div>
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
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
	function change(event,id) {
		var btn = event.target;
		var tr  = btn.parentElement.parentElement;
		var td  = tr.firstElementChild;
		var userOkId = td.innerText;
		
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				document.getElementById("change-ok-btn-" +id).value = "정지";
				document.getElementById("change-ok-btn-" +id).setAttribute("class", "btn btn-xs btn-danger");
			}
		}
		xhr.open('GET', '/adminpage/user/user_change.jsp?id=' + userOkId);
		xhr.send(null);
		
	}
	function changeRollback(event,id) {
		var btn = event.target;
		var tr  = btn.parentElement.parentElement;
		var td  = tr.firstElementChild;
		var userNoId = td.innerText;
		
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				document.getElementById("change-no-btn-" +id).value = "정상";
				document.getElementById("change-no-btn-" +id).setAttribute("class", "btn btn-xs btn-primary");
			}
		}
		xhr.open('GET', '/adminpage/user/user_change2.jsp?id=' + userNoId);
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
</html>
<%@page import="kr.go.booktopia.dao.AnnouncementDao"%>
<%@page import="kr.go.booktopia.util.StringUtil"%>
<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 공지사항</title>
</head>
<body>
<% pageContext.setAttribute("sideMode", "news"); %>
<%@ include file="/common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/board-side.jsp" %>
		</div>
		<div class="col-sm-7 contents">
			<h3>도서관 소식</h3>
			<div class="panel panel-default">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
					<%
						Criteria criteria = new Criteria();
						DaoManager daoManager = DaoManager.getInstance();
						
						AnnouncementDao announcementDao = new AnnouncementDao();
						
						final int rowsPerPage = 10;
						final int naviPerPage = 5;
						
						int p = StringUtil.strToNumber(request.getParameter("p"), 1);
						
						int beginIndex = (p-1) * rowsPerPage + 1;
						int endIndex = p * rowsPerPage;
						
						criteria.setBeginIndex(beginIndex);
						criteria.setEndIndex(endIndex);	
						
						String opt = request.getParameter("opt");
						String keyword = request.getParameter("keyword");
						
						if (opt != null && keyword != null) {
							criteria.setOpt(opt);
							criteria.setKeyword(keyword);
						}
					
						int totalRows = announcementDao.getTotalRows(criteria);
						int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
						
						int totalNaviBlocks = (int) Math.ceil(totalPages/(double) naviPerPage);
						int currentNaviBlock = (int)Math.ceil(p/(double) naviPerPage);
						
						int beginPage = (currentNaviBlock - 1) * naviPerPage +1;
						int endPage = currentNaviBlock * naviPerPage;
						if(currentNaviBlock == totalNaviBlocks) {
							endPage = totalPages;
						}
						
						List<Announcement> announcements = daoManager.list(Announcement.class, criteria);
						
						Criteria annCriteria = new Criteria();
						annCriteria.setBeginIndex(1);
						annCriteria.setEndIndex(5);

						List<Announcement> notices = announcementDao.getNotices(annCriteria);
					%>
					
					<%for (Announcement notice : notices) {
						%>
						<tr class="info">
							<td><%=notice.getId() %></td>
							<td ><span class="glyphicon glyphicon-volume-up"></span><a href="/openboard/notice/viewcount.jsp?id=<%=notice.getId()%>"> <%=notice.getTitle() %></a></td>
							<td>[관리자] <%=notice.getAdmin().getName() %></td>
							<td><%=notice.getSimpleCreatedAt() %></td>
							<td><%=notice.getViewCount() %></td>
						</tr>
					
					<%} %>
					
					<%
						for (Announcement announcement : announcements) {
					%>
						<tr>
							<td><%=announcement.getId() %></td>
							<td><a href="/openboard/notice/viewcount.jsp?id=<%=announcement.getId()%>"><%=announcement.getTitle() %></a></td>
							<td>[관리자] <%=announcement.getAdmin().getName() %></td>
							<td><%=announcement.getSimpleCreatedAt() %></td>
							<td><%=announcement.getViewCount() %></td>
						</tr>
					<%} %>
					</tbody>
				</table>
			</div>
			<div class='text-center'>
				<form class='form-inline' action='list.jsp' method='get'>
				<input type="hidden" name="p" id="p-field" value="<%=p %>"/>
					<div class='form-group'>		
						<label class='sr-only'>옵션</label>
							<select class='form-control' name='opt'>
								<option value='title' <%="title".equals(opt) ? "selected":"" %>> 제목</option>
								<option value='writer' <%="writer".equals(opt) ? "selected":"" %>> 작성자</option>
							</select>
					</div>
					<div class='form-group'>
						<label class='sr-only'>검색어</label>
							<input type='text' class='form-control' name='keyword' value="<%=StringUtil.nullToBlank(keyword) %>"/>
					</div>
						<button type='submit' class='btn btn-primary'>검색</button>
				</form>
			</div>
			<div class="row text-center">
				<ul class="pagination">
						<%if(currentNaviBlock > 1) { %>
							<li><a href="list.jsp?p=<%=(currentNaviBlock-1) * naviPerPage %>">&laquo;</a></li>
						<%} else { %>
							<li class='disabled'><a href="list.jsp?p=<%=p%>">&laquo;</a></li>
						<%}
							
							if (p>1) {
						%>
							<li><a href='list.jsp?p=<%=(p-1)%>'>&lt;</a></li>	
						<%} else {%>
							<li class='disabled'><a href='list.jsp?p=1'>&lt;</a></li>
						<%
							}
							
							for (int index=beginPage; index<=endPage; index++) {
						%>
								<li class='<%=(p==index? "active":"")%>'><a href="list.jsp?p=<%=index%>"><%=index %></a></li>		
						<%}
						
							if(p<totalPages) {
						%>		
								<li><a href='list.jsp?p=<%=p + 1%>'>&gt;</a></li>
						<%} else {%>
								<li class='disabled'><a href="list.jsp?p=<%=p%>">&gt;</a></li>
						<%}
						
							if(currentNaviBlock<totalNaviBlocks) {
						%>
							<li><a href='list.jsp?p=<%=currentNaviBlock * naviPerPage + 1%>'>&raquo;</a></li>
						<%} else { %>
							<li class='disabled'><a href='list.jsp?p=<%=p%>'>&raquo;</a></li>
						<%} %>
					</ul>	
			</div>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
</html>
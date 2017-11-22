<%@page import="kr.go.booktopia.vo.QuestionAnswer"%>
<%@page import="kr.go.booktopia.dao.QuestionAnswerDao"%>
<%@page import="kr.go.booktopia.dao.QuestionDao"%>
<%@page import="kr.go.booktopia.util.StringUtil"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.Question"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 묻고답하기</title>
</head>
<body>
<% pageContext.setAttribute("sideMode", "qa"); %>
<%@ include file="/common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/board-side.jsp" %>
		</div>
		
		<%
			Criteria criteria = new Criteria();
			DaoManager qnaDao = DaoManager.getInstance();
			QuestionDao questionDao = new QuestionDao();	
			
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
		
			int totalRows = questionDao.getTotalRows(criteria);
			int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
			
			int totalNaviBlocks = (int) Math.ceil(totalPages/(double) naviPerPage);
			int currentNaviBlock = (int)Math.ceil(p/(double) naviPerPage);
			
			int beginPage = (currentNaviBlock - 1) * naviPerPage +1;
			int endPage = currentNaviBlock * naviPerPage;
			if(currentNaviBlock == totalNaviBlocks) {
				endPage = totalPages;
			}
			
			List<Question> questions = qnaDao.list(Question.class, criteria);
			
			QuestionAnswerDao questionAnswerDao = new QuestionAnswerDao();
			
			for (Question question : questions) {
				QuestionAnswer isQuestionAnswer = DaoManager.getInstance().read(QuestionAnswer.class, question.getId());
				if (isQuestionAnswer != null) {
					QuestionAnswer questionAnswer = questionAnswerDao.getLatestAnswer(question.getId());
					question.setQuestionAnswer(questionAnswer);
				}
			}
			
		%>
		<div class="col-sm-8 contents">
			<h3>묻고 답하기</h3>								
			<div class="panel panel-default">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>처리상태</th>
							<th>작성일</th>
							<th>조회</th>
						</tr>
					</thead>
					<tbody>
					<%						
						for (Question question : questions) {
					%>
						<tr>
							<td><%=question.getId() %></td>
							<td><a href="viewcount.jsp?id=<%=question.getId() %>"><%=question.getTitle() %></a></td>
							<td><%=question.getUser().getName()%></td>
							<%// 처리중 어떻게 할지 생각하기... %>
							<td><%="Y".equals(question.getQuestionAnswer()==null ? "N" : question.getQuestionAnswer().getCharIsActive()) ? 
									"<a class='btn btn-danger btn-xs'>답변완료</a>" : "<a class='btn btn-primary btn-xs'>처리중</a>" %></td>
							<td><%=question.getSimpleCreatedAt() %></td>
							<td> <%=question.getViewCount() %></td>
						</tr>
					<%} %>
					</tbody>
				</table>
			</div>
			
			<a href="form.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<div class='text-center'>
				<form id="search-form" class='form-inline' action='list.jsp' method='get'>
				<input type="hidden" name="p" id="p-field" value="<%=p %>"/>
					<div class='form-group'>		
						<label class='sr-only'>옵션</label>
						<select class='form-control' name='opt' >
							<option value='title' <%="title".equals(opt) ? "selected":"" %>> 제목</option>
							<option value='writer' <%="writer".equals(opt) ? "selected":"" %>> 작성자</option>
						</select>
					</div>
					<div class='form-group'>
						<label class='sr-only'>검색어</label>
						<input type='text' class='form-control' name='keyword' value="<%=StringUtil.nullToBlank(keyword) %>"/>
					</div>
					<button type="submit" class='btn btn-primary'>검색</button>
<!-- 					<button type="button" class="btn btn-default" onclick="formInit(event)">초기화</button> -->
				</form>	
				
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
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script>
	function formInit(event) {
		event.preventDefault();
		document.getElementById("p-field").value = 1;
		document.getElementById("opt").value = "title";
		document.getElementById("keyword").value = "";
		document.getElementById("search-form").submit();
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
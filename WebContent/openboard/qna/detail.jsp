<%@page import="kr.go.booktopia.dao.QuestionDao"%>
<%@page import="kr.go.booktopia.vo.QuestionAnswer"%>
<%@page import="oracle.net.aso.q"%>
<%@page import="kr.go.booktopia.vo.Question"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 질문답변</title>
</head>
<body>
<% pageContext.setAttribute("sideMode", "qa"); %>
<%@ include file="/common/navbar.jsp" %>
<%
	int id = Integer.parseInt(request.getParameter("id"));

	//글정보 가져오기
	DaoManager daoManager = DaoManager.getInstance();
	QuestionDao questionDao = new QuestionDao();
	
	Question question = daoManager.read(Question.class, id);
	
	QuestionAnswer questionAnswer = daoManager.read(QuestionAnswer.class, id);
	Question nextQuestion = questionDao.getNextQuestion(id);
	Question preQuestion = questionDao.getPreQuestion(id);
	
	User userInfo = (User) session.getAttribute("userInfo");
	
%>
<div class="container">
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/board-side.jsp" %>
		</div>
		<div class="col-sm-7 contents">
			 <h3>묻고 답하기</h3>
			   <div class="panel panel-default">
			      <table class="table">
			         <colgroup>
			            <col width="15%">
			            <col width="20%">
			            <col width="15%">
			            <col width="20%">
			            <col width="15%">
			            <col width="15%">
			         </colgroup>
			         <tbody>
			            <tr>
			               <th>제목</th>
			               <td colspan="5"><%=question.getTitle() %></td>
			            </tr>
			            <tr>
			               <th>작성자</th>
			               <td><%=question.getUser().getName() %></td>
			               <th>작성일</th>
			               <td><%=question.getSimpleCreatedAt() %></td>
			               <th>조회수</th>
			               <td><%=question.getViewCount() %></td>
			            </tr>
			            <tr>
			               <td colspan="6"><%=question.getContent() %></td>
			            </tr>
			         </tbody>
			      </table>
			      <div class="panel-footer">
			      	<%if (preQuestion != null) {%>
			         	<a href="/openboard/qna/viewcount.jsp?id=<%=preQuestion.getId() %>" class="btn btn-default">이전글</a>
			         <%} %>
			         	<a href="/openboard/qna/list.jsp" class="btn btn-primary">목록으로</a>
			         <%if (nextQuestion != null) {%>
			         	<a href="/openboard/qna/viewcount.jsp?id=<%=nextQuestion.getId() %>" class="btn btn-default">다음글</a>
			         <%} %>
			         <%
			         	if (userInfo != null) {
				        // 	int userInfoId = userInfo.getId();
				         //	int qnaUserId = question.getUser().getId();
			         		if (userInfo.getId() == question.getUser().getId()) {%>
			         		<div class="pull-right">
			         			<a href="rewrite.jsp?id=<%=question.getId() %>" class="btn btn-info" >수정</a>
			         			<a class="btn btn-danger" id="delete-question-user">삭제</a>
			         		</div>
			         <%	} else if (userInfo.getCharIsAdmin().equals("Y")) { %>
			         			<a class="btn btn-danger pull-right" id="delete-question-admin">삭제</a>
			         <%		}
			         		}%>
			         
			      </div>
			   </div>
			   <%
			    if (questionAnswer != null) {
			   %>
			    <div class="panel panel-default">
				<table class="table ">
					<tbody>
						<tr>
							<th>답변입니다.</th>
						</tr>
						<tr>
							<th>작성자</th>
							<td>[관리자]<%=questionAnswer.getAdmin().getName() %></td>
							<th>작성일</th>
							<td><%=questionAnswer.getSimpleCreatedAt()%></td>
						</tr>
						<tr>
			               <td colspan="6"><%=questionAnswer.getContent() %></td>
			            </tr>
					</tbody>
				</table>
				<%
					if (userInfo != null) {
						if (userInfo.getCharIsAdmin().equals("Y")) {
				%>
				 <div class="panel-footer text-center">
					 <a href="rewriteanswer.jsp?qnaid=<%=questionAnswer.getQuestionId() %>" class="btn btn-info">수정</a>
					<a class="btn btn-danger" id="delete-answer">삭제</a>
			    </div>
			    
				<%
						}
					} %>
			   </div>
			   
			   <%} else { 
			   			if (userInfo != null) {
			   				if (userInfo.getCharIsAdmin().equals("Y")) {%>
			   
			   <div>
					<form class="form-horizontal" method="post" action="addAnswer.jsp">
						<input type="hidden" name="qnaid" value="<%=question.getId()%>">
						<div class="form-group">
							<div class="col-sm-12">
								<textarea rows="3" class="form-control" name="content"></textarea>
							</div>
							<div class="text-center">
								<button type="submit" class="btn btn-default">답변등록</button>
							</div>
						</div>
					</form>
				</div>
				<%		}
						} 
					}%>
		</div>
	</div>
</div>  
<%@ include file="/common/footer.jsp" %>   
</body>
<script type="text/javascript">

	var id = <%=question.getId()%>
	
	var usertag = document.getElementById("delete-question-user");
	if (usertag != null) {
		usertag.addEventListener("click", function() {
			var confirmed = confirm ("삭제하시겠습니까?");
			if (confirmed) {
				location.href="delete.jsp?id="+id;
			}
		});
	}
	
	var admintag = document.getElementById("delete-question-admin");
	if (admintag != null) {
		admintag.addEventListener("click", function() {
			var confirmed = confirm ("삭제하시겠습니까?");
			if (confirmed) {
				location.href="delete.jsp?id="+id;
			}
		});
	}
	
	var answertag = document.getElementById("delete-answer");
	if(answertag != null) {
		answertag.addEventListener("click", function() {
			var confirmed = confirm ("삭제하시겠습니까?");
			if (confirmed) {
				location.href="deleteAnswer.jsp?qnaid="+id;
			}
		});
	}
</script>
</html>
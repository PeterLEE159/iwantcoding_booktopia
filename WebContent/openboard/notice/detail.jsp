
<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
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
				<table class="table">
					<colgroup>
						<col width="15%">
						<col width="20%">
						<col width="15%">
						<col width="20%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					
					<%
						int id = Integer.parseInt(request.getParameter("id"));
					
						DaoManager daoManager = DaoManager.getInstance();
						Announcement announcement = daoManager.read(Announcement.class, id);
						
						User userInfo = (User) session.getAttribute("userInfo");
		
					%>
					
					<tbody>
						<tr>
							<th>제목</th>
							<td colspan="5"><%=announcement.getTitle() %></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>[관리자] <%=announcement.getAdmin().getName() %></td>
							<th>날짜</th>
							<td><%=announcement.getSimpleCreatedAt() %></td>
							<th>조회수</th>
							<td><%=announcement.getViewCount() %></td>
						</tr>
						<tr>
							<td colspan="6"><%=announcement.getContent() %></td>
						</tr>
					</tbody>
				</table>
				<div class="panel-footer text-center">
					<a href="list.jsp" class="btn btn-primary btn-sm">목록으로</a>
				<%if (userInfo != null) { 
						if(userInfo.getCharIsAdmin().equals("Y")) {%>
					<a href="rewrite.jsp?id=<%=announcement.getId()%>" class="btn btn-info btn-sm">수정</a>
					<a class="btn btn-danger btn-sm" id="leave">삭제</a>
				<%
						}	
					}
				%>
				</div>
			</div>
			
			
				
		</div>
	</div>
</div>		
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
	
	var id = <%=announcement.getId()%>
	
	var tag = document.getElementById("leave");
	if (tag != null) {
		tag.addEventListener("click", function() {
			var confirmed = confirm ("삭제하시겠습니까?");
			if (confirmed) {
				location.href="delete.jsp?id="+id;
			}
		});
	}
</script>
</html>
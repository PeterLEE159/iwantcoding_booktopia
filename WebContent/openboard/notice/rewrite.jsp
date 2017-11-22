<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 공지사항 수정</title>
</head>
<body>
<% pageContext.setAttribute("sideMode", "news"); %>
<%@ include file="/common/navbar.jsp" %>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL2.jsp" %>  
<div class="container">
		<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		
		
	<%
		int id = Integer.parseInt(request.getParameter("id"));
	
		DaoManager daoManager = DaoManager.getInstance();
		Announcement announcement = daoManager.read(Announcement.class, id);
		
		String realTitle = "";
		
		if ("Y".equals(announcement.getCharIsEmergency())) {
			String title = announcement.getTitle();
			realTitle = title.substring(5);
		}
	%>
					
	<div class="col-sm-7 contents">
			<h3 class="well">공지/새소식 등록</h3>	
			<form class="well" method="post" action="rewriteupdate.jsp">
			<input class="hidden" name="annid" value="<%=announcement.getId() %>" />
				<div class="form-group">				
                    <div class="radio">
                     	<label><input type="radio" name="emergency" value="Y" <%="Y".equals(announcement.getCharIsEmergency()) ? "checked" : "" %>>공지글</label>
                        <label><input type="radio" name="emergency" value="N" <%="N".equals(announcement.getCharIsEmergency()) ? "checked" : "" %>>일반글</label>   
                  </div>
                  
				</div>
				<div class="form-group">
					<label>제목</label>
					<input id="input-title" type="text" class="form-control" name="title" value="<%="Y".equals(announcement.getCharIsEmergency()) ? realTitle : announcement.getTitle() %>"/>
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea rows="10" class="form-control" name="content"><%=announcement.getContent() %></textarea>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-info btn-sm">수정</button>
					<a href="list.jsp" class="btn btn-warning btn-sm">취소</a>
				</div>
			</form>
		</div>		
	</div>
</div>	
<%@ include file="/common/footer.jsp" %>
</body>
<script>
		
	var title = "<%=announcement.getTitle()%>"
	
	document.getElementById("radio-1").addEventListener("click", function(event) {
		document.getElementById("input-title").setAttribute("value", "[공지] "+title)
	})
	
	document.getElementById("radio-2").addEventListener("click", function(event) {
		document.getElementById("input-title").setAttribute("value", title)
	})
</script>
</html>
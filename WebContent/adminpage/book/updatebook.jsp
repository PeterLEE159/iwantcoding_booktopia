<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.util.DateUtil"%>
<%@page import="kr.go.booktopia.vo.Book"%>
<%@page import="kr.go.booktopia.vo.BookGenre"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.Genre"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서수정</title>
</head>
<body>    
<% pageContext.setAttribute("url","/index.jsp"); %>
<% pageContext.setAttribute("sideMode", "addBook");%>
<%@ include file="/common/navbar.jsp" %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>
<div class="container">		
	<div class="row">
		<div class="col-sm-2 side">
			<%@ include file="/common/admin-side.jsp" %>
		</div>
		
		<%
			
			int bookId = Integer.parseInt(request.getParameter("bno"));
			Book book = DaoManager.getInstance().read(Book.class, bookId);
			
			List<Genre> genreList = DaoManager.getInstance().list(Genre.class, null);
 			
			Criteria criteria = new Criteria();
			criteria.setBookId(bookId);
			
			List<BookGenre> bookGenres = DaoManager.getInstance().list(BookGenre.class, criteria);
 			
			
		%>
		
		<div class="col-sm-7 contents">
			<fieldset>
			   <div class="text-center">
			         <h3>도서수정</h3>
			    </div>
			    
			   <form class="form-horizontal" action="update.jsp" method="post" enctype="multipart/form-data">
			    <fieldset>
			      
			      <div class="col-sm-8">    
			      
			        <div class="form-group">
			        	<input type="hidden" name="bookno" value="<%=book.getId() %>"/>
			          	<label class="col-sm-4 control-label">도서번호</label>  
			          	<div class="col-sm-8">
			            <label class="control-label"><%=book.getId() %></label>
			          </div>      
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label">책제목</label>  
			          <div class="col-sm-8">
			             <input type="text" name="booktitle" value="<%=book.getName() %>" class="form-control input-md">
			          </div>
			        </div>
			        
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label">저자 </label>
			          <div class="col-sm-8">
			            <input id="text" name="bookwriter"  value="<%=book.getWriter().getName() %>" class="form-control" >
			          </div>
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label" >역자</label>
			          <div class="col-sm-8">
			            <input type="text" name="booktrans" 
			            <% if (book.getTranslator() != null) { %>
			            	value="<%=book.getTranslator().getName() %>"			            	
			            <% } %>	
			           	 class="form-control">			            
			          </div>
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label">출판사</label>  
			          <div class="col-sm-8">
			             <input type="text" name="bookpub" value="<%=book.getPublisher().getName() %>"class="form-control ">  
			          </div>
			        </div>
			
			        <div class="form-group">
			          <label class="col-sm-4 control-label" for="phone">발행일</label>  
			          <div class="col-sm-8">
			             <input type="text" name="pubdate" value="<%=DateUtil.yyyymmdd(book.getPublishDate()) %>" class="form-control">
			          </div>
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label" for="phone">장르</label>  
			          <div class="col-sm-8">
			          <div>
			          
			          <%for(Genre genre : genreList) { %>
			             <div>
			             	<input type="checkbox" name="bookgenre" id="genre-<%=genre.getId() %>" 
			             	<%  for(BookGenre bookGenre : bookGenres) { %>
			             		<%= bookGenre.getGenreId() == genre.getId() ? "checked" : ""%>
			             	<% } %>	             	
			             	 /> <%=genre.getType() %>
			             </div>
			             
			          <%} %>
			          </div>
			          </div>
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label" for="phone">책소개</label>  
			          <div class="col-sm-8">
			             <textarea class="form-control" rows="5" cols="" name="bookintro"><%=book.getContent() %></textarea>
			          </div>
			        </div>
			       
			        <div class="form-group">
			          <label class="col-sm-4 control-label"></label>
			          <div class="col-sm-8">
			             <button type="submit" class="btn btn-success">변경하기</button>
			            <a href="/adminpage/book/addbooklist.jsp" class="btn btn-danger">취소</a>
			          </div>
			        </div>
			
			        </div>
			         
			        <div class="col-sm-2">
			           <div class="row">
<!-- 			           <label class="btn btn-default btn-sm" for="img">이미지 등록하기</label> -->
			              <img id="image-uploaded" width="200px" src="/images/book/<%=book.getImageUrl()%>"/>
			              <input type="file" accept="image/*" name="bookimages" id="file-upload"/>
			           </div>
			        </div>     		        
			        </fieldset>
			        </form>
			</fieldset>
		</div>
	</div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script type="text/javascript">
var upload = document.getElementById('file-upload'),
	imageTag = document.getElementById('image-uploaded');
	
upload.onchange = function (e) {
	e.preventDefault();
	
	var file = upload.files[0],
		reader = new FileReader();
	reader.onload = function (event) {
		imageTag.src = event.target.result;
	};
	reader.readAsDataURL(file);
	
	return false;
};
</script>
</html>






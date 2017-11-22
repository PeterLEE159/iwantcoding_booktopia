<%@page import="kr.go.booktopia.vo.BookPublisher"%>
<%@page import="kr.go.booktopia.vo.BookTranslator"%>
<%@page import="kr.go.booktopia.vo.BookWriters"%>
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
<title>북토피아: 도서등록</title>
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
	 	List<Genre> genreList = DaoManager.getInstance().list(Genre.class, null);
	%>
		
		<div class="col-sm-7 contents">
			<fieldset>
			   <div class="text-center">
			         <h3>도서 등록</h3>
			    </div>
			    
			   <form class="form-horizontal" action="add.jsp" method="post" enctype="multipart/form-data">
			    <fieldset>
			      
			      <div class="col-sm-8">    
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label">책제목</label>  
			          <div class="col-sm-8">
			             <input type="text" name="title" class="form-control input-md" required="">
			          </div>      
			        </div>
			        
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label">저자 </label>
			          <div class="col-sm-8">
			          	<select name="writer" id="writer-list" onchange="onWriterChange(this)">
			          		<option value="">새로등록</option>
			          		<% 
			          			DaoManager daoManager = DaoManager.getInstance();
			          			List<BookWriters> bookWriters = daoManager.listAll(BookWriters.class);
			          			for (BookWriters writer : bookWriters) {
			          		%>
			          		<option value="<%=writer.getId()%>"><%=writer.getName() %></option>
			          		<%
			          			}
			          		%>
			          	</select>
			            <input id="ip-writername" type="text" name="new-writer" class="form-control">
			            <% if ("1".equals(request.getParameter("fail"))) { %>
			            <p class="alert alert-danger">저자를 입력해주세요!</p>
			            <% } %>
			          </div>
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label" >역자</label>
			          <div class="col-sm-8">
			          	<select name="translator" id="translator-list" onchange="onWriterChange2(this)">
			          		<option value="">새로등록</option>
			          		<% 
			          			List<BookTranslator> bookTranslators = daoManager.listAll(BookTranslator.class);
			          			for (BookTranslator translator : bookTranslators) {
			          		%>
			          		<option value="<%=translator.getId()%>"><%=translator.getName() %></option>
			          		<%
			          			}
			          		%>
			          	</select>
			            <input id="ip-translatorname" type="text" name="new-translator" class="form-control">
			          </div>
			        </div>
			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label">출판사</label> 
			          <div class="col-sm-8">
			          	 <select name="publisher" id="publisher-list" onchange="onWriterChange3(this)">
			          		<option value="">새로등록</option>
			          		<% 
			          			List<BookPublisher> bookPublisher = daoManager.listAll(BookPublisher.class);
			          			for (BookPublisher publisher : bookPublisher) {
			          		%>
			          		<option value="<%=publisher.getId()%>"><%=publisher.getName() %></option>
			          		<%
			          			}
			          		%>
			          	</select>
			             <input id="ip-publishername" type="text" name="new-publisher" class="form-control ">
			             <% if ("2".equals(request.getParameter("fail"))) { %>
			             	<p class="alert alert-danger">출판사를 입력해주세요!</p>
			             <% } %>  
			          </div>
			        </div>
			
			        <div class="form-group">
			          <label class="col-sm-4 control-label" for="phone">발행일</label>  
			          <div class="col-sm-8">
			             <input type="date" name="publishdate" class="form-control" required="">
			          </div>
			        </div>		
			
			        <div class="form-group">

                  		<label class="col-sm-4 control-label" >장르</label>  
	                    <div class="col-sm-8">
	                     <% for(Genre genre : genreList) { %>
	                        <div>
	                           <input type="checkbox" name="genres"  value="<%=genre.getId()%>" id="genre-<%=genre.getId() %>"><%=genre.getType() %>
	                        </div>
	                     <% } %>
                		</div>
               		</div>

			        
			        <div class="form-group">
			          <label class="col-sm-4 control-label" for="phone">책소개</label>  
			          <div class="col-sm-8">
			             <textarea class="form-control" name="bookexplain" rows="5" cols="" required=""></textarea>
			          </div>
			        </div>
			        
			        
			       
			        <div class="form-group">
			          <label class="col-sm-4 control-label"></label>
			          <div class="col-sm-8">
			             <button type="submit" class="btn btn-success">등록하기</button>
			            <a href="/adminpage/book/addbooklist.jsp" class="btn btn-danger">취소</a>
			          </div>
			        </div>
			
			        </div>
			         
			        <div class="col-sm-2">
			           <div class="row">
<!-- 			           <label class="btn btn-default btn-sm" for="img">이미지 등록하기</label> -->
			              <img id="output_image" width="200px" />
			              <input type="file" accept="image/*" name="bookimages" onchange="preview_image(event)"/>
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
// 	(function() {
// 		var select = document.getElementById("writer-list");
// 		var options = select.getElementsByTagName("option");
// 		var size = options.length;
		
		
// 	})();
	
	function onWriterChange(el) {
		var ipWriterName = document.getElementById('ip-writername');
		if(el.value == '') {
			ipWriterName.value = '';
			return;
		}
		ipWriterName.value = el.options[el.selectedIndex].innerText;
			
	}
	
	function onWriterChange2(el) {
		var ipTransratorName = document.getElementById('ip-translatorname');
		if(el.value == '') {
			ipTransratorName.value = '';
			return;
		}
		ipTransratorName.value = el.options[el.selectedIndex].innerText;
			
	}
	
	function onWriterChange3(el) {
		var ipPublisherName = document.getElementById('ip-publishername');
		if(el.value == '') {
			ipPublisherName.value = '';
			return;
		}
		ipPublisherName.value = el.options[el.selectedIndex].innerText;
			
	}
	
	function preview_image(event) 
	{
	 var reader = new FileReader();
	 reader.onload = function()
	 {
	  var output = document.getElementById('output_image');
	  output.src = reader.result;
	 }
	 reader.readAsDataURL(event.target.files[0]);
	}
	
	

	
	
// 	var selected  = select.value;
	
	
	
// 	console.log(wName[1].innerText);
// 	var input = document.querySelector("select+input").innerText;
// 	console.log(input);
</script>
</html>
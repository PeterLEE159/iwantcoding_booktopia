<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="kr.go.booktopia.vo.BookComment"%>
<%@page import="java.util.List"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.vo.Book"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 책 상세정보</title>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<%
	returnUrl = request.getParameter("returnUrl");
	int bid = Integer.parseInt(request.getParameter("id"));
	
	DaoManager manager = DaoManager.getInstance();
	
	
	Book book = manager.read(Book.class, bid);
	book.setViewCount(book.getViewCount()+1);
	new BookDao().addViewCount(book);
	
	Criteria criteria = new Criteria();
	criteria.setBookId(bid);
	List<BookComment> commentList = manager.list(BookComment.class, criteria);

%>

<div class="container top-buffer">
	<div class="row">
		<div class="col-md-4">
			<img class="img-thumbnail img-response" src="<%=book.getFullImageUrl() %>">
			<div class="btn-group top-buffer">
				<a class="btn btn-default" target="_black" href="/do.book_preview?previewUrl=<%=book.getPreviewUrl() %>"><i class="fa fa-eye fa-fw"></i>미리보기</a>
				<a class="btn btn-default" href="/book/booking.jsp?id=<%=bid%>"><i class="fa fa-book fa-fw"></i>예약하기</a>
			</div>
		</div>
		<div class="col-md-8">
			<h3><%=book.getName() %>          
			<span class="rating" style="margin-left: 24px;">
				<span class="star<%=(book.getRatingPoint() == 5 ? " filled" : "")%>"></span>
				<span class="star<%=(book.getRatingPoint() >= 4 ? " filled" : "")%>"></span>
				<span class="star<%=(book.getRatingPoint() >= 3 ? " filled" : "")%>"></span>
				<span class="star<%=(book.getRatingPoint() >= 2 ? " filled" : "")%>"></span>
				<span class="star<%=(book.getRatingPoint() >= 1 ? " filled" : "")%>"></span>
			</span>
			
			<small>
				<a id="btn-recommend" class="a-unstyle pull-right right-buffer btn btn-primary font-white" href="javascript:recommend(<%=(user != null ? user.getId() : 0) %>, <%=book.getId()%>)">
				<i class="fa fa-heart-o fa-fw"></i><%=book.getRecommendCount() %></a>
			</small>
			</h3>
			<table class="table table-hover top-buffer">
				<colgroup>
					<col width="30%">
					<col width="70%">
				</colgroup>
				<tr>
					<th>저자</th>
					<td><% if(book.getWriter() != null) { %>
							<%=book.getWriter().getName() %>
						<% } %>
					</td>
				</tr>
				<tr>
					<th>역자</th>
					<td><% if(book.getTranslator() != null) { %>
							<%=book.getTranslator().getName() %>
						<% } %>
					</td>
				</tr>
				<tr>
					<th>출판사</th>
					<td><% if(book.getPublisher() != null) { %>
							<%=book.getPublisher().getName() %>
						<% } %>
					</td>
				</tr>
				<tr>
					<th>장르</th>
					<td><%=book.getGenre() %></td>
				</tr>
				<tr>
					<th>출판날짜</th>
					<td><%=book.yyyymmdd(book.getPublishDate()) %></td>
				</tr>
				<tr>
					<th>평점</th>
					<td><%=book.getRatingPoint() %></td>
				</tr>
				<tr>
					<th>조회횟수</th>
					<td><%=book.getViewCount() %></td>
				</tr>
				<tr>
					<th>대여횟수</th>
					<td><%=book.getRentalCount() %></td>
				</tr>	
			</table>
		</div>
	</div>
	
	
	<div class="row">
		<h2 class="page-header">책 소개</h2>
		<p><%=book.getContent() %></p>
	</div>
	<hr class="divider">
	<div class="row">
		<h2 class="page-header">댓글</h2>
		<div class="panel panel-primary">
			<div class="panel-heading"><h4 style="color: white;">댓글작성</h4></div>
			<div class="panel-body">
				<h3>
					<span id="rating-write" class="rating">
						<span id="star-5" class="star star-hover"></span>
						<span id="star-4" class="star star-hover"></span>
						<span id="star-3" class="star star-hover"></span>
						<span id="star-2" class="star star-hover"></span>
						<span id="star-1" class="star star-hover filled"></span>
					</span>
					<small id="star-desc" style="margin-left: 24px;">최저 사용처 장작, 최대 사용처 장작</small>
				</h3>
				<textarea id="text-comment" class="form-control" placeholder="댓글쓰기" rows="5"></textarea>
				<a id="btn-comment" class="btn btn-primary pull-right top-buffer" href="javascript:storeComment(<%=(user != null ? user.getId() : 0)%>, <%=book.getId()%>)">저장하기</a>
			</div>
			<input type="hidden" id="star-current" value="1">			
		</div>
		
		<div id="comment-body">
		<% for(BookComment comment : commentList) { %>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4><%=comment.getUser().getName() %>
					<span class="rating">
						<span class="star<%=(comment.getRatingPoint() == 5 ? " filled" : "")%>"></span>
						<span class="star<%=(comment.getRatingPoint() >= 4 ? " filled" : "")%>"></span>
						<span class="star<%=(comment.getRatingPoint() >= 3 ? " filled" : "")%>"></span>
						<span class="star<%=(comment.getRatingPoint() >= 2 ? " filled" : "")%>"></span>
						<span class="star<%=(comment.getRatingPoint() >= 1 ? " filled" : "")%>"></span>
					</span>
					<small class="pull-right"><%=comment.getSimpleCreatedAt() %></small>
					</h4>
				</div>
				<div class="panel-body">
					<%=comment.getContent() %>
				</div>
				<% if(user != null && user.getId() == comment.getUser().getId()) { %>
				<div class="panel-body">
					<span class="pull-right">
						<a onclick="setUpdate(<%=comment.getId() %>, '<%=comment.getContent()%>')" class="btn btn-default btn-sm" data-toggle="modal" data-target="#div-commentupdate"><i class="fa fa-pencil fa-fw"></i>수정</a>
						<a type="submit" class="btn btn-default btn-sm" href="javascript:deleteComment(<%=comment.getId() %>)"><i class="fa fa-trash fa-fw"></i>삭제</a>
					</span>
				</div>
				<% } %>
				
			</div>
		<% } %>
		</div>
		<hr class="divider">
		
	</div>
	<% if(user != null) { %>
		<input type="hidden" value="<%= user.getId()%>" id="input-userid">
	<% } %>
</div>
<div class="modal fade" id="div-commentupdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">댓글 수정하기</h4>
      </div>
      <div class="modal-body">
        <form action="/update.book_comment" method="post">
        	<textarea id="ta-modal-comment" class="form-control" rows="5">
        		
        	</textarea>
        	<input type="hidden" id="ip-modal-commentid">
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="updateComment()">수정</button>
      </div>
      
    </div>
  </div>
</div>
<%@ include file="/common/footer.jsp" %>
</body>
<script>
	(function() {
		var stars = document.getElementById('rating-write').getElementsByTagName('span');
		var size = stars.length;
		
		var starCurrent = document.getElementById('star-current');
		for(var i=0; i < size; i++) {
			(function() {
				var star = stars[i];
				star.addEventListener('mouseover', function(event) {
					star = event.target;
					var starNum = star.id.replace('star-', '');
					setRatingDesc(starNum);
				});
			})();
		}
		for(var i=0; i < size; i++) {
			(function() {
				var star = stars[i];
				star.addEventListener('click', function(event) {
					star = event.target;
					var starNum = star.id.replace('star-', '');
					starCurrent.value = starNum;
					rating(starNum);
					setRatingDesc(starNum);
				});
			})();
		}
	})();
	
	function setUpdate(commentId, commentContent) {
		document.getElementById('ip-modal-commentid').value = commentId;
		document.getElementById('ta-modal-comment').value = commentContent;
	}
	
	function rating(starNum) {
		var stars = document.getElementById('rating-write').getElementsByTagName('span');
		var size = stars.length;
		for(var i=0; i < size; i++) {
			var star = stars[i];
			var id = star.id.replace('star-', '');
			
			if(id <= starNum) 
				star.className = star.className + ' filled';
			else 
				star.className = star.className.replace(' filled', '');
			
		}
	}
	
	function storeComment(userId, bookId) {
		if(userId == 0) {
			alert('로그인을 해주세요');
			$('#login-form').modal();
			return;
		}
		var textComment = document.getElementById('text-comment');
		var starCurrent = document.getElementById('star-current');
		var starDesc = document.getElementById('star-desc');
		
		var content = textComment.value;
		var rating = starCurrent.value;
		
		
		
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				value = window.location.href;
				window.location.href = value;
				return;
				var comment = JSON.parse(xhr.responseText);
				var body = document.getElementById('comment-body');
				var htmlContent = '';
				var commentUploaderUserId = comment.user.id;

				
				htmlContent += "<div class='panel panel-default'>";
				htmlContent += "	<div class='panel-heading'>";
				htmlContent += "		<h4>"+(comment.user.name);
				htmlContent += "			<span class='rating'>";
				htmlContent += "				<span class='star"+(comment.ratingPoint == 5 ? ' filled' : '')+"'></span>";
				htmlContent += "				<span class='star"+(comment.ratingPoint >= 4 ? ' filled' : '')+"'></span>";
				htmlContent += "				<span class='star"+(comment.ratingPoint >= 3 ? ' filled' : '')+"'></span>";
				htmlContent += "				<span class='star"+(comment.ratingPoint >= 2 ? ' filled' : '')+"'></span>";
				htmlContent += "				<span class='star"+(comment.ratingPoint >= 1 ? ' filled' : '')+"'></span>";
				htmlContent += "			</span>";
				htmlContent += "			<small class='pull-right'>"+(new Date().toISOString().substring(0, 10)) +"</small>";
				htmlContent += "		</h4>";
				htmlContent += "	</div>";
				htmlContent += "	<div class='panel-body'>";
				htmlContent += 			comment.content;
				htmlContent += "	</div>";
				htmlContent += "	<div class='panel-body'>";
				htmlContent += "		<span class='pull-right'>";
				htmlContent += "			<a onclick='setUpdate("+comment.id+", '"+comment.content+"')' class='btn btn-default btn-sm' data-toggle='modal' data-target=''#div-commentupdate'><i class='fa fa-pencil fa-fw'></i>수정</a>";
				htmlContent += "			<a class='btn btn-default btn-sm' href='javascript:deleteComment("+comment.id+")'><i class='fa fa-trash fa-fw'></i>삭제</a>";
				htmlContent += "			<input type='hidden' value='"+comment.id+"'>";
				htmlContent += "	</span>";
				htmlContent += "</div>";
				
				body.innerHTML = htmlContent + body.innerHTML;
				
				
				
				textComment.value = '';
				starDesc.innderText = '최저 사용처 장작, 최대 사용처 장작';
				starCurrent.value = 1;
				rating(1);
			}
		}
		xhr.open('POST', '/create.book_comment');
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
		xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
		xhr.setRequestHeader("Pragma","no-cache");
		xhr.send("content="+content+"&rating="+rating+"&bookId="+bookId);
		
	}
	
	
	
	
	
	function setRatingDesc(starNum) {
		var starDesc = document.getElementById('star-desc');
		starDesc.innerText = starNum == 1 ? '최저 사용처 장작, 최대 사용처 장작' : starNum == 2 ? 
				'수면제로 강력추천' : starNum == 3 ? 
				'평균적으로 읽을만한 책' : starNum == 4 ? 
				'이 책은 추천할만 하다' : starNum == 5 ? 
				'내 인생 최고의 책' : '';
	}
	

	function recommend(userId, bookId) {
		if(userId == 0) {
			alert('로그인을 해주세요');
			$('#login-form').modal();
			return;
		}
			
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				var message = JSON.parse(xhr.responseText);
				if(message.statusCode == 0) {
					// 이미 추천한 내용
					alert('이미 추천하셨습니다');
					return;
				} else if(message.statusCode == -1) {
					alert('유효한 요청이 아닙니다')
					return;
				} else {
					// 새로 추천
					
					var btnRecommend = document.getElementById('btn-recommend');
					var recommend = parseInt(btnRecommend.innerText) + 1
					btnRecommend.innerHTML = "<i class='fa fa-heart-o fa-fw'></i>"+recommend;
				}
			}
		}
		xhr.open('POST', '/do.book_recommend');
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
		xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
		xhr.setRequestHeader("Pragma","no-cache");
		xhr.send("bookid="+bookId+"&userid="+userId);
	}
	function deleteComment(commentId) {
		var isDelete = confirm('댓글을 삭제하시겠습니까?');
		if(isDelete) {
			var xhr = new XMLHttpRequest();
			xhr.onload = function() {				
				if(xhr.status == 200) {
					value = window.location.href;
					window.location.href = value;
				}
			}
			xhr.open('POST', '/do.comment_change');
			xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
			xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
			xhr.setRequestHeader("Pragma","no-cache");
			xhr.send("mode=0&id="+commentId);
		}
		
	}
	
	function updateComment(commentId, content) {
		var commentId = document.getElementById('ip-modal-commentid').value;
		var content = document.getElementById('ta-modal-comment').value;
		
		
		var xhr = new XMLHttpRequest();
		xhr.onload = function() {
			if(xhr.status == 200) {
				value = window.location.href;
				window.location.href = value;
			}
		}
		
		xhr.open('POST', '/do.comment_change');
		xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
		xhr.setRequestHeader("Cache-Control","no-cache, must-revalidate");
		xhr.setRequestHeader("Pragma","no-cache");
		xhr.send("mode=1&id="+commentId+"&content="+content);
		
	}
	
</script>
</html>
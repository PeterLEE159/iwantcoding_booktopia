<%@page import="kr.go.booktopia.config.Dir"%>
<%@page import="kr.go.booktopia.util.IbatisUtil"%>
<%@page import="kr.go.booktopia.config.Pagination"%>
<%@page import="java.util.Arrays"%>
<%@page import="kr.go.booktopia.util.StringUtil"%>
<%@page import="kr.go.booktopia.vo.Criteria"%>
<%@page import="kr.go.booktopia.dao.BookDao"%>
<%@page import="kr.go.booktopia.vo.Book"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.Genre"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/style.css">
<title>북토피아: 도서검색</title>
</head>
<body>
<%
	List<Genre> genreList = DaoManager.getInstance().list(Genre.class, null);
	String k = request.getParameter("keyword");
	String o = request.getParameter("opt");
	if("제목".equals(o)) o ="name";
	if("저자".equals(o)) o ="writer";
	if("출판사".equals(o)) o ="publisher";
	String g = request.getParameter("genre");
	Criteria criteria = new Criteria();
	criteria.setPage(1);
	List<Book> bookList = null;
	String searchMode = null;
	if(g == null || g.isEmpty()) {
		if(k == null || k.isEmpty()) {
			// 최신순으로 검색
			searchMode = "latest";
			bookList = new BookDao().readLatestBook(criteria);
		} else {
			// 키워드만으로 검색
			searchMode = "all";
			g = "";
			for(Genre genreEach : genreList)
				g += genreEach.getId();
			criteria.setKeyword(k);
			criteria.setOpt(o);
			criteria.setIds(IbatisUtil.convertIdsToIntergerList(genreList));
			bookList = DaoManager.getInstance().search(Book.class, criteria);
		}
	} else {
		if(k == null || k.isEmpty()) {
			// 장르만으로 검색
			searchMode = "genreOnly";
			criteria.setIds(StringUtil.convertStringToIntList(g));
			bookList = DaoManager.getInstance().search(Book.class, criteria);
		} else {
			// 장르와 키워드로 검색
			searchMode = "all";
			criteria.setKeyword(k);
			criteria.setOpt(o);
			criteria.setIds(StringUtil.convertStringToIntList(g));
			bookList = DaoManager.getInstance().search(Book.class, criteria);
		}
	}
	
%>	
	<input type="hidden" id="keyword" value="<%=StringUtil.nullToBlank(k) %>">
	<input type="hidden" id="opt" value="<%=StringUtil.nullToBlank(o) %>">
	<input type="hidden" id="genre" value="<%=StringUtil.nullToBlank(g) %>">
	<input type="hidden" id="page" value="<%=2 %>">
	<input type="hidden" id="searchMode" value="<%=searchMode %>">
	<input type="hidden" id="screenMode" value="v-book-div">
	
	<%@ include file="/common/navbar.jsp"%>
	<div class="container text-center">
		<h1 style="color: #82ba44;">자료 검색</h1>
	</div>
	<div class="container">
		<hr class="colorgraph">
		<section>
			<div id="genre-selector">
				<% for (int i=0; i < genreList.size(); i++) {
					Genre genre = genreList.get(i); %>
				<div class="col-md-3">
					<input class="style-check" type="checkbox" id="genre-<%=genre.getId() %>"
					<% if(!StringUtil.isEmpty(g))  { %>
						<% for(int j=0; j < g.length(); j++) { %>
							<%= String.valueOf(genre.getId()).equals(String.valueOf(g.charAt(j))) ? "checked" : "" %>
						<% } %>
					<% } %>
					>
					<label for="genre-<%=genre.getId() %>"><%=genre.getType() %></label>
				</div>
				<% } %>
			</div>
			<hr class="colorgraph">
			<div class="row">
				<div class="col-md-2">
					<select id="search-opt" class="form-control">
						<option>제목</option>
						<option <%="writer".equals(o) ? "selected" : "" %>>저자</option>
						<option <%="publisher".equals(o) ? "selected" : "" %>>출판사</option>
					</select>
				</div>
				<div class="col-md-8">
					<input id="search-keyword" type="search" class="form-control" value="<%=StringUtil.isEmpty(k) ? "" : k %>">
				</div>
				<div class="col-md-2">
					<a id="btn-search" class="btn btn-primary">검색</a>
				</div>
			</div>
		</section>
		<hr class="colorgraph">
		<section id="section-search-book">
			<div class="btn-group pull-right" role="group" style="margin-right: 90px;">
				<button id="btn-v" type="button" class="btn btn-default btn-lg active"><i class="fa fa-th"></i></button>
				<button id="btn-h" type="button" class="btn btn-default btn-lg"><i class="fa fa-list-ul fa-fw"></i></button>
			</div>
			<br><br><br><br><br>
			<div id="book-container">
			<% for(Book book : bookList) { %>
				<a href="/book/detail.jsp?id=<%=book.getId() %>&returnUrl=/search/searchbook.jsp">
					<div class="wow fadeIn v-book-div">
						<img src="<%=book.getFullImageUrl() %>">
						<div class="book-desc">
							
							<table class="table borderless" style="padding-bottom: 0px; margin-bittin: 0px;">
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
	
								<tr>
									<th>제목</th>
									<td><%=book.getName() %></td>
								</tr>
								<tr>
									<th>출판사</th>
									<td><%=book.getPublisher().getName() %></td>
								</tr>
								<tr>
									<th>저자</th>
									<td><%=book.getWriter().getName() %></td>
								</tr>
								<tr>
									<th>장르</th>
									<td><%=book.getGenre() %></td>
								</tr>
								<tr>
									<th>평점</th>
									<td>
										<span class="rating">
											<span class="star<%=(book.getRatingPoint() == 5 ? " filled" : "")%>"></span>
											<span class="star<%=(book.getRatingPoint() >= 4 ? " filled" : "")%>"></span>
											<span class="star<%=(book.getRatingPoint() >= 3 ? " filled" : "")%>"></span>
											<span class="star<%=(book.getRatingPoint() >= 2 ? " filled" : "")%>"></span>
											<span class="star<%=(book.getRatingPoint() >= 1 ? " filled" : "")%>"></span>
										</span>
										<p style="float: right; margin-right: 16px;"><%=book.getRatingPoint() %></p>
									</td>
								</tr>
								
							</table>
							<div class="row text-right" style="padding-bottom: 8px; margin-top: 0px; padding-top: 0px;">
								<span class="right-buffer green-text"><i class="fa fa-heart fa-fw"></i><%=book.getRecommendCount() %></span>
								<span class="right-buffer green-text"><i class="fa fa-book fa-fw"></i><%=book.getRentalCount() %></span>
								<span class="right-buffer green-text"><i class="fa fa-eye fa-fw"></i><%=book.getViewCount() %></span>
							</div>
						</div>
					</div>
				</a>
			<% } %>
			</div>
		</section>
	</div>
	<%@ include file="/common/footer.jsp"%>
	<script>
		function urlBuilder(data) {
		    return Object.keys(data).map(function(key) {
		        return [key, data[key]].map(encodeURIComponent).join("=");
		    }).join("&");
		}
		
		function refresh() {
			var checkboxes = document.getElementById('genre-selector').getElementsByTagName('input');
			var size = checkboxes.length;
			var keyword = document.getElementById('search-keyword').value;
			var opt = document.getElementById('search-opt').value;
			var genre = '';
			for(var i= 0;i<size; i++) {
				var check = checkboxes[i];
				if(check.checked) {
					genre += check.id.replace('genre-', '');
				}
			}
			var params = {
				'keyword': keyword,
				'opt': opt,
				'genre': genre
			};
			url = window.location.href;
			if(url.includes('?')) 
				url = url.substring(0, url.lastIndexOf('?'))
			url += '?' + urlBuilder(params);
			window.location.href = url;
		}
		
		(function() {
			document.getElementById('btn-search').addEventListener('click', function() {
				refresh();
			});
			
			document.getElementById('btn-v').addEventListener('click', function(event) {
				var inputScreen = document.getElementById('screenMode');
				if(inputScreen.value == 'v-book-div')
					return;
				inputScreen.value = 'v-book-div';
				
				var btnV = event.target;
				var btnH = document.getElementById('btn-h');
				
				btnV.setAttribute('class', btnV.getAttribute('class')+' active');
				btnH.setAttribute('class', btnH.getAttribute('class').replace(' active', ''));
				
				var descs = document.getElementsByClassName('book-desc');
				var containers = document.getElementsByClassName('wow');
				
				var size = containers.length;
				for(var i =0; i < size; i++) {
					var container = containers[i];
					container.setAttribute('class', container.getAttribute('class').replace('h-book-div', 'v-book-div'));
				}
				
				size = descs.length;
				for(var i =0; i < size; i++) {
					var desc = descs[i];
					desc.setAttribute('class', desc.getAttribute('class').replace(' h-desc', ''));
				}	
			});
			
			document.getElementById('btn-h').addEventListener('click', function() {
				var inputScreen = document.getElementById('screenMode');
				if(inputScreen.value == 'h-book-div')
					return;
				inputScreen.value = 'h-book-div';
				
				var btnV = document.getElementById('btn-v');
				var btnH = event.target;
				
				btnV.setAttribute('class', btnV.getAttribute('class').replace(' active', ''));
				btnH.setAttribute('class', btnH.getAttribute('class')+' active');
				
				var descs = document.getElementsByClassName('book-desc');
				var containers = document.getElementsByClassName('wow');
				
				var size = containers.length;
				for(var i =0; i < size; i++) {
					var container = containers[i];
					container.setAttribute('class', container.getAttribute('class').replace('v-book-div', 'h-book-div'));
				}
				
				size = descs.length;
				for(var i =0; i < size; i++) {
					var desc = descs[i];
					desc.setAttribute('class', desc.getAttribute('class')+' h-desc');
				}
			});
			
			var count = 0;
			
			window.onscroll = function(ev) {
			    if ((window.innerHeight + window.pageYOffset) >= document.body.offsetHeight) {
			    	if(count == 0) {
			    		count = 1;
				    	search(true);
				    	setTimeout(function() {
				    		count = 0;
				    	}, 2000);
			    	}
			    	
			    }
			};
			
			document.getElementById('search-keyword').addEventListener('keyup', function(event) {
				var keyword = event.target.value;
				var length = keyword.length;
				if(length >= 2) {
					// 검색시작
					document.getElementById('keyword').value = keyword;
					console.log(document.getElementById('keyword').value);
					search(false);
				}
			});
			
			document.getElementById('search-keyword').addEventListener('keyup', function(event) {
				if (event.keyCode == 13) {
			        refresh();
			    }
			});
			
			
		})();
		
		
		
		function search(added) {
			var inputPage = document.getElementById('page');
	    	var keyword = document.getElementById('keyword').value;
	    	var opt = document.getElementById('opt').value;
	    	var genre = document.getElementById('genre').value;
	    	var page = parseInt(inputPage.value);
	    	
	    	var searchMode = document.getElementById('searchMode').value;
	    	var screenMode = document.getElementById('screenMode').value;
	    	
	    	inputPage.value = page;
	    	
	    	var bookContainer = document.getElementById('book-container');
	    	var htmlContent = '';
	    	
	    	var url = '/do.book-search?';
	    	var params = {
	    		'keyword': keyword,
	    		'opt': opt,
	    		'genre': genre,
	    		'page': page,
	    		'mode': searchMode
	    	};
	    	
	    	url += urlBuilder(params);
	    	var xhr = new XMLHttpRequest();
			xhr.onload = function() {
	    		var books = JSON.parse(xhr.responseText);
	    		var bookSize = books.length;
	    		
	    		for(var i =0; i< bookSize; i++) {
	    			var book = books[i];
	    			
	    			htmlContent += "<a href='/book/detail.jsp?id="+book.id+"&returnUrl=/search/searchbook.jsp'>";
	    			htmlContent += "<div class='"+screenMode+" wow fadeIn'>";
	    			htmlContent += "	<img src='"+book.fullImageUrl+"'>";
	    			htmlContent += "	<div class='book-desc"+(screenMode == 'v-book-div' ? '' : ' h-desc')+"'>";
		    		htmlContent += "		<table class='table borderless'>";
	    			htmlContent += "			<colgroup>";
		    		htmlContent += "				<col width='30%'>";
	    			htmlContent += "				<col width='70%'>";
	    			htmlContent += "			</colgroup>";
	    			htmlContent += "			<tr>";
		    		htmlContent += "				<th>제목</th>";
		    		htmlContent += "				<td>"+book.name+"</td>";
			    	htmlContent += "			</tr>";
		    		htmlContent += "			<tr>";
		    		htmlContent += "				<th>출판사</th>";
		    		htmlContent += "				<td>"+book.publisher.name+"</td>";
			    	htmlContent += "			</tr>";
		    		htmlContent += "			<tr>";
		    		htmlContent += "				<th>저자</th>";
		    		htmlContent += "				<td>"+book.writer.name+"</td>";
			    	htmlContent += "			</tr>";
			    	htmlContent += "			<tr>";
		    		htmlContent += "				<th>장르</th>";
		    		htmlContent += "				<td>"+book.genre+"</td>";
			    	htmlContent += "			</tr>";
			    	htmlContent += "			<tr>";
			    	htmlContent += "				<th>평점</th>";
			    	htmlContent += "				<td>";
				    htmlContent += "					<span class='rating'>";
					htmlContent += "						<span class='star"+(book.ratingPoint == 5 ? ' filled' : '')+"'></span>";
					htmlContent += "						<span class='star"+(book.ratingPoint >= 4 ? ' filled' : '')+"'></span>";
					htmlContent += "						<span class='star"+(book.ratingPoint >= 3 ? ' filled' : '')+"'></span>";
					htmlContent += "						<span class='star"+(book.ratingPoint >= 2 ? ' filled' : '')+"'></span>";
					htmlContent += "						<span class='star"+(book.ratingPoint >= 1 ? ' filled' : '')+"'></span>";
					htmlContent += "					</span>";
					htmlContent += "					<p style='float: right; margin-right: 16px;'>"+book.ratingPoint.toFixed(1)+"</p>";
					htmlContent += "				</td>";
					htmlContent += "			</tr>";
		    		htmlContent += "		</table>";
		    		htmlContent += "	</div>";
		    		htmlContent += "</div>";
		    		htmlContent += "</a>";
	    		}
	    		if(added)
	    			bookContainer.innerHTML += htmlContent;
	    		else
	    			bookContainer.innerHTML = htmlContent;
	    	};
	    	
	    	xhr.open('get', url);
	    	xhr.send(null);
		}
	</script>
</body>
</html>
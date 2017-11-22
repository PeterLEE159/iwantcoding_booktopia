<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String sideMode = String.valueOf(pageContext.getAttribute("sideMode"));
%>
<h3>열린마당</h3>
<ul class="list-group">
	<a class="list-group-item<%="news".equals(sideMode) ? " active" : ""%>" href="/openboard/notice/list.jsp"><i class="fa fa-newspaper-o fa-fw"></i> 도서관소식</a>
	<a class="list-group-item<%="qa".equals(sideMode) ? " active" : ""%>" href="/openboard/qna/list.jsp"><i class="fa fa-question-circle-o fa-fw"></i> 묻고답하기</a>
</ul>
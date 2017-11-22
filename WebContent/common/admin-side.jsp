<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String sideMode = String.valueOf(pageContext.getAttribute("sideMode"));
%>
<h3>관리자 페이지</h3>
<ul class="list-group admin-side">		
	<a class="list-group-item<%="addBook".equals(sideMode) ? " active" : ""%>" href="/adminpage/book/addbooklist.jsp"><i class="fa fa-list fa-fw"></i>도서 등록/수정</a>	
	<a class="list-group-item<%="rental".equals(sideMode) ? " active" : ""%>" href="/adminpage/borrow/borrowlist.jsp"><i class="fa fa-paper-plane fa-fw"></i> 대출목록</a>
	<a class="list-group-item<%="memberManage".equals(sideMode) ? " active" : ""%>" href="/adminpage/user/membermanagement.jsp"><i class="fa fa-user fa-fw"></i> 회원관리</a>
	<a class="list-group-item<%="notice".equals(sideMode) ? " active" : ""%>" href="/adminpage/notice/noticeform.jsp"><i class="fa fa-question-circle fa-fw"></i>공지/새소식 등록</a>
	<a class="list-group-item<%="adminWish".equals(sideMode) ? " active" : ""%>" href="/adminpage/wish/adminwish.jsp"><i class="fa fa-book fa-fw"></i> 희망도서 신청목록</a>
</ul>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sideMode = String.valueOf(pageContext.getAttribute("sideMode"));
%>
<h3>마이 페이지</h3>
<ul class="list-group">
  <a class="list-group-item<%="rental".equals(sideMode) ? " active" : ""%>" href="/mypage/borrow/borrow.jsp"><i class="fa fa-book fa-fw"></i> 대출도서조회</a>
  <a class="list-group-item<%="userinfo".equals(sideMode) ? " active" : ""%>" href="/mypage/privacy/user.jsp"><i class="fa fa-info fa-fw"></i> 회원정보</a>
  <a class="list-group-item<%="booking".equals(sideMode) ? " active" : ""%>" href="/mypage/booking/reserve.jsp"><i class="fa fa-clock-o fa-fw"></i> 예약내역</a>
  <a class="list-group-item<%="wish".equals(sideMode) ? " active" : ""%>" href="/mypage/wish/wishbook.jsp"><i class="fa fa-plus fa-fw"></i> 희망도서신청</a>
</ul>
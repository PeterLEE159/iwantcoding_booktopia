
<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@page import="kr.go.booktopia.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%
	// 로그인이 되지 않은 사용자가 접근했을 때 로그인 후 되돌아갈 url 지정
	pageContext.setAttribute("url", "/simple-jsp-board/index.jsp");
%>
<%@ include file="../common/logincheck.jsp" %> --%>
<% pageContext.setAttribute("url","/index.jsp"); %>
<%@ include file="/loginpage/login_returnURL2.jsp" %>
<%
	
	request.setCharacterEncoding("utf-8");
	
	String title = request.getParameter("title");
	String content = request.getParameter("contents");
	String emergency = request.getParameter("emergency");
	
	User user = (User) session.getAttribute("userInfo");
	
	Announcement announcement = new Announcement();
	
	if("Y".equals(emergency)) {
		announcement.setTitle("[공지] "+title);
	} else {
		announcement.setTitle(title);		
	}
	announcement.setContent(content);
	announcement.setCharIsEmergency(emergency);
	announcement.setAdmin(user);
	
	DaoManager dm =DaoManager.getInstance();
	dm.create(announcement);
	
	
	response.sendRedirect("/openboard/notice/list.jsp");
%>

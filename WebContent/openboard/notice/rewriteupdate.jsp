<%@page import="kr.go.booktopia.vo.User"%>
<%@page import="kr.go.booktopia.vo.Announcement"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%pageContext.setAttribute("url","/index.jsp");%>
<%@ include file="/loginpage/login_returnURL2.jsp" %>  
<%
	
	
	request.setCharacterEncoding("utf-8");

	int id = Integer.parseInt(request.getParameter("annid"));	

	User userInfo = (User) session.getAttribute("userInfo");
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String emergency = request.getParameter("emergency");

	DaoManager daoManager = DaoManager.getInstance();
	Announcement announcement = daoManager.read(Announcement.class, id);
	
	if ("Y".equals(emergency)) {
		announcement.setTitle("[공지] "+title);			
	} else {
		announcement.setTitle(title);	
	}
	
	announcement.setContent(content);
	announcement.setCharIsEmergency(emergency);
	announcement.setAdmin(userInfo);
	
	daoManager.update(announcement);
	
	response.sendRedirect("detail.jsp?id="+id);
	
%>

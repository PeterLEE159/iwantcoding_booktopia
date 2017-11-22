<%@page import="kr.go.booktopia.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
 User userAdmin = (User) session.getAttribute("userInfo");
   if(session.getAttribute("userInfo")==null || !userAdmin.getCharIsAdmin().equals("Y")){
      String url = (String)pageContext.getAttribute("url");
      
      String path = "/loginpage/loginform.jsp?deny=2&returnUrl="+url;
      response.sendRedirect(path);
            
      return;
   }

%>

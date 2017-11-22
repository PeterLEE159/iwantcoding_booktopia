<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   if(session.getAttribute("userInfo")==null){
      String url = (String)pageContext.getAttribute("url");
      
      String path = "/loginpage/loginform.jsp?deny=1&returnUrl="+url;
      response.sendRedirect(path);
            
      return;
   }

%>
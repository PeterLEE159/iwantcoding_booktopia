<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="kr.go.booktopia.vo.User"%>
<%@page import="kr.go.booktopia.dao.DaoManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String id = request.getParameter("inputLoginId");
   String pwd = request.getParameter("inputLoginPwd");
   String returnUrl = request.getParameter("returnUrl");
   
   DaoManager dao = DaoManager.getInstance();
   User user = dao.read(User.class, id);
   
   if(user == null || "N".equals(user.getCharIsActive())){
      response.sendRedirect("/index.jsp?fail=1");
      return;
   }
   
   String sha256Pwd = DigestUtils.sha256Hex(pwd);
   
   if(!user.getPassword().equals(sha256Pwd)){
      response.sendRedirect("/index.jsp?fail=1");
      return;
   }
   
   session = request.getSession(true);
   
   session.setAttribute("userInfo", user);
   
   if(returnUrl == null){
      response.sendRedirect("../index.jsp");
   }else{
      response.sendRedirect(returnUrl);
   }
   
%>
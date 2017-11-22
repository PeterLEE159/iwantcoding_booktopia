<%@page import="kr.go.booktopia.util.MailUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="kr.go.booktopia.web.SMTPServlet"%>
<%@ page
   import="java.util.*,
   java.io.*,
   javax.mail.*,
   javax.mail.internet.*,
   javax.activation.*"%>
<% 
	request.getParameter("");	

   //제목
   String subject = "[Booktopia] 아이디를 알려드립니다.";
	//내용
   String contents = "고객님의 아이디를 알려드릴게요."; 
   // 받는이 메일주소 
   String to ="" ; 
   // 보내는이 메일주소
   String from = "leeshva093091@gmail.com"; 

   MailUtil.sendEmail(subject, contents, to);
%>
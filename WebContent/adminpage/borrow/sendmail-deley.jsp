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

   //제목
   String subject = "[Booktopia] 연체확인 메일";
	//내용
   String contents = "너님 지금 연체중 확인 고고"; 
   // 받는이 메일주소 
   String to = "leeshva@naver.com"; 
   // 보내는이 메일주소
   String from = "leeshva093091@gmail.com"; 

   MailUtil.sendEmail(subject, contents, to);
%>
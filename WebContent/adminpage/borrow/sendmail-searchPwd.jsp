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
   String subject = "[Booktopia] 새로운 비밀번호 메일입니다.";
	//내용
   String contents = "새로운 비밀번호입니다!"; 
   // 받는이 메일주소 
   String to = "leeshva@naver.com"; 
   // 보내는이 메일주소
   String from = "leeshva093091@gmail.com"; 

   MailUtil.sendEmail(subject, contents, to);
%>
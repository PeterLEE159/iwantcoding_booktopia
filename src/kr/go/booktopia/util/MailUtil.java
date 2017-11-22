package kr.go.booktopia.util;


import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import kr.go.booktopia.web.SMTPServlet;



public class MailUtil {

	   public static void sendEmail(String subject, String text, String to) throws Exception {
	      
	      Properties props = new Properties(); 
	      props.put("mail.transport.protocol", "smtp");
	      props.put("mail.smtp.host", "smtp.gmail.com");
	      props.put("mail.smtp.port", "465");
	      props.put("mail.smtp.starttls.enable", "true");
	      props.put("mail.smtp.socketFactory.port", "465");
	      props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	      props.put("mail.smtp.socketFactory.fallback", "false");
	      props.put("mail.smtp.auth", "true");

	      Authenticator auth = new SMTPServlet();

	      Session sess = javax.mail.Session.getInstance(props,auth);
	      Message msg = new MimeMessage(sess);

	      msg.setFrom(new InternetAddress("leeshva093091@gmail.com"));
	      InternetAddress address = new InternetAddress(to);
	      msg.setRecipient(Message.RecipientType.TO, address);
	      msg.setSubject(subject);
	      msg.setSentDate(new java.util.Date());
	      msg.setContent(text, "text/html;charset=utf-8");
	      Transport.send(msg);
	   }
}



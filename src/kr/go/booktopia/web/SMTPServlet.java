package kr.go.booktopia.web;

import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;

public class SMTPServlet extends Authenticator {
   public SMTPServlet() {
        super();
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        String username = "leeshva093091@gmail.com";
        String password = "tmdghks33";
        return new PasswordAuthentication(username, password);
    }
}
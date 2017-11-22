package kr.go.booktopia.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseServlet extends HttpServlet{
	
	public final void setRequestContentType(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public final void setResponseJsonType(HttpServletResponse res, String pattern) {
		res.setContentType(pattern + ";charset=utf-8");
	}
	public final void setResponseJsonType(HttpServletResponse res) {
		res.setContentType("text/plain;charset=utf-8");
	}
	public final void setResponseContentType(HttpServletResponse res) {
		res.setContentType("text/html;charset=utf-8");
	}
	
	public void throwException() throws ServletException {
		throw new ServletException("유효한 요청이 아닙니다");
	}
	
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.service(req, res);
	}
	
}

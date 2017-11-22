package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.vo.BookComment;


@WebServlet("/do.comment_change")
public class BookChangeServlet extends BaseServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.setRequestContentType(req);
		this.setResponseJsonType(res, "text/plain");
		
		String id = req.getParameter("id");
		String mode = req.getParameter("mode");
		
		
		if(id == null || id.isEmpty() || mode == null || mode.isEmpty()) 
			this.throwException();
		
		int intMode = Integer.parseInt(mode);
		BookComment c = new BookComment();
		PrintWriter out = res.getWriter();
		c.setId(Integer.parseInt(id));
		Gson gson = new Gson();
		DaoManager m = DaoManager.getInstance();
		try {
			
			if(intMode == 0) {
				m.delete(c);
				out.println("true");
				return;
				
			} else {
				String content = req.getParameter("content");
				if(content == null || content.isEmpty())
					this.throwException();
				c.setContent(content);
				
				m.update(c);
				out.print("true");
				return;
			}
		} catch(SQLException ex) {
			throw new ServletException(ex);
		}
		
	}
}

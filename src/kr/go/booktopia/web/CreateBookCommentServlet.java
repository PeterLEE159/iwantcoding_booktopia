package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.BookComment;
import kr.go.booktopia.vo.User;

@WebServlet("/create.book_comment")
public class CreateBookCommentServlet extends BaseServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.setRequestContentType(req);
		this.setResponseJsonType(res, "text/plain");
		HttpSession session = req.getSession(false);
		
		if(session == null) {
			throw new ServletException("유저인증 필요");
		}
		
		User loginUser= (User)session.getAttribute("userInfo");
		User user = new User();
		user.setName(loginUser.getName());
		user.setId(loginUser.getId());
		
		String content = req.getParameter("content");
		String rating = req.getParameter("rating");
		String bookId = req.getParameter("bookId");
		
		if(content == null || content == null || content == null) {
			throw new ServletException("유효한 요청이 아닙니다");
		}
		
		Book book = new Book();
		book.setId(Integer.parseInt(bookId));
		BookComment comment = new BookComment();
		comment.setContent(content);
		comment.setRatingPoint(Double.parseDouble(rating));
		comment.setUser(user);
		comment.setBook(book);
		DaoManager manager = DaoManager.getInstance();
		PrintWriter out = res.getWriter();
		try {
			manager.create(comment);
			
			out.println(new Gson().toJson(comment));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}

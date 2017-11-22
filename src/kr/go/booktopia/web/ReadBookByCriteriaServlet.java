package kr.go.booktopia.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.go.booktopia.dao.BookDao;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.Criteria;

@WebServlet("/read.bookByCriteria")

public class ReadBookByCriteriaServlet extends BaseServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.setResponseContentType(res);
		String strMode = req.getParameter("mode");
		String page = req.getParameter("page");
		if(page == null || page.isEmpty()) page = "1";
		if(strMode == null) {
			throw new ServletException("유효한 요청이 아닙니다");
		}
		int mode = Integer.parseInt(strMode);
		Criteria c = new Criteria();
		c.setSearchRange(5);
		c.setPage(1);
		
		List<Book> bookList = null;
		try {
			if(mode == 0 ) {
			
				bookList = new BookDao().readByRentalCount(c);
			} else if(mode == 1) {
			
				bookList = new BookDao().readByRecommentCount(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(bookList != null) {
			res.getWriter().println(new Gson().toJson(bookList));
		}
		
	}
}

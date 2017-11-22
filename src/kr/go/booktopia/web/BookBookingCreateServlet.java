package kr.go.booktopia.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.util.DateUtil;
import kr.go.booktopia.util.StringUtil;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.BookBooking;

@WebServlet("/do.create_booking")
public class BookBookingCreateServlet extends BaseServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String strUserId = req.getParameter("userid");
		String strBookId = req.getParameter("bookid");
		String date = req.getParameter("date");
		if(StringUtil.isEmpty(strUserId) || StringUtil.isEmpty(strBookId) || StringUtil.isEmpty(date)) {
			this.throwException();
		}
		Book book = new Book();
		book.setId(Integer.parseInt(strBookId));
		BookBooking b = new BookBooking();
		b.setBook(book);
		b.setUserId(Integer.parseInt(strUserId));
		b.setBookingDate(DateUtil.yyyymmdd(date));
		
		try {
			DaoManager.getInstance().create(b);
			res.getWriter().println(true);
			return;
		} catch (SQLException e) {
			throw new ServletException(e);
		}
	}
}

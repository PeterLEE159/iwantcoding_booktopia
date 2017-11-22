package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.go.booktopia.dao.BookingDao;
import kr.go.booktopia.util.DateUtil;
import kr.go.booktopia.util.StringUtil;
import kr.go.booktopia.vo.BookBooking;
import kr.go.booktopia.vo.BookRental;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.User;

@WebServlet("/do.bookbookingbymonth")
public class BookBookingReadServlet extends BaseServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.setResponseJsonType(res);
		
		String strId = req.getParameter("id");
		String strDate = req.getParameter("date");
		
		if(StringUtil.isEmpty(strId) || StringUtil.isEmpty(strDate))
			this.throwException();
		
		Date date = DateUtil.yyyymmdd(strDate);
		
		Criteria c = new Criteria();
		c.setDate(date);
		c.setBookId(Integer.parseInt(strId));
		
		List<BookBooking> bookingList;
		try {
			bookingList = new BookingDao().readByDate(c);
			res.getWriter().println(new Gson().toJson(bookingList));
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			throw new ServletException(e);
		}
	}
}

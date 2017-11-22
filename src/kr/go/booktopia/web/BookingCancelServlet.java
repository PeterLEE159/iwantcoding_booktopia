package kr.go.booktopia.web;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.vo.BookBooking;

@WebServlet("/mypage/booking/do.booking-cancel")
public class BookingCancelServlet extends BaseServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String ids = req.getParameter("booking-id");
		
		String[] bookingIds = ids.split(",");
		for(String a : bookingIds){
			System.out.println(a);
		}
		DaoManager daoManager = DaoManager.getInstance();
		for (String bookingId : bookingIds) {
			BookBooking bookBooking = new BookBooking();
			bookBooking.setId(Integer.parseInt(bookingId));
			try {
				daoManager.delete(bookBooking);
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
		
		res.sendRedirect("/mypage/booking/reserve.jsp");
		
	}	

}

/*package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.go.booktopia.adapter.DateSerializer;
import kr.go.booktopia.dao.BookDao;
import kr.go.booktopia.vo.BookRental;

@WebServlet("/mypage/borrow/rentalbook2.do")
public class RentalList2Servlet extends BaseServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		BookDao bookDao = new BookDao();
		
		try {
			List<BookRental> bookRentals = bookDao.getRentalBooksById(1);
			
			for (BookRental bookRental : bookRentals) {
				int delayDate = bookRental.getDelayDate();
				bookRental.setDelayDate(delayDate);
			}
			
			res.setContentType("text/plain;charset=utf-8");
			PrintWriter pw = res.getWriter();
			GsonBuilder builder = new GsonBuilder();
			builder.registerTypeAdapter(Date.class, new DateSerializer());
			Gson gson = builder.create();
			
			String text = gson.toJson(bookRentals);
			pw.write(text);
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
	}
}

*/
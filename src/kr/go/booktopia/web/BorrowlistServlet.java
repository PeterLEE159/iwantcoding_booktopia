/*package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.go.booktopia.adapter.DateSerializer;
import kr.go.booktopia.dao.BookDao;
import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.vo.BookRental;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.PagingCriteria;
@WebServlet("/adminpage/borrow/lendbook.do")
public class BorrowlistServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String lendType = req.getParameter("type");
		// 현재 페이지 번호
		int p = Integer.parseInt(req.getParameter("p"));
		
		final int rowsPerPage = 10;
		final int naviPerPage = 5;
		
		DaoManager daoManager = DaoManager.getInstance();
		BookDao bookDao = new BookDao();
		try {
			
			//int totalRows = bookDao.count();
			//int totalPages = (int) Math.ceil(totalRows/(double) rowsPerPage);
			// 전체 페이지 내비게이션 블록 개수 계산
			//int totalNaviBlockCount = (int) Math.ceil(totalPages/(double) naviPerPage);
			// 현재 페이지 내비게이션 블록 번호 계산
			//int currentBlockNo = (int) Math.ceil(p/(double) naviPerPage);
			// 페이지 내비게이션으로 표시할 시작 페이지 번호와 끝 페이지 번호 계산
			//int beginPage = (currentBlockNo - 1) * naviPerPage + 1;
			//int endPage = currentBlockNo * naviPerPage;
			//if (currentBlockNo == totalNaviBlockCount) {
			//	endPage = totalPages;
			//}
			// 현재 페이지 번호에 해당하는 데이터 조회에 사용할 시작 인덱스 계산
			int beginIndex = (p - 1) * rowsPerPage + 1;
			// 현재 페이지 번호에 해당하는 데이터 조회에 사용할 끝 인덱스 계산
			int endIndex = p * rowsPerPage;
			
			PagingCriteria pagingCriteria = new PagingCriteria();
			pagingCriteria.setBeginIndex(beginIndex);
			pagingCriteria.setEndIndex(endIndex);
			
			
			//////////////////////////////////////////////////////////////
			
			List<BookRental> bookRentals = new ArrayList<>();
			if ("A".equals(lendType)){ 
				bookRentals = daoManager.list(BookRental.class, new Criteria());
			} else if ("R".equals(lendType)) {
				bookRentals = bookDao.getRentalBoooks();
			} else if ("N".equals(lendType)) {
				bookRentals = bookDao.getNonRentalBoooks();
			}
			
			res.setContentType("text/plain;charset=utf-8");
			PrintWriter pw = res.getWriter();
			GsonBuilder builder = new GsonBuilder();
			builder.registerTypeAdapter(Date.class, new DateSerializer());
			Gson gson = builder.create();
			
			String text = gson.toJson(bookRentals);
			pw.write(text);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
	}
}*/

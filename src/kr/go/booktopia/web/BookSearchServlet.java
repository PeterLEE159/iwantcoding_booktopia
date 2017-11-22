package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.go.booktopia.config.Pagination;
import kr.go.booktopia.dao.BookDao;
import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.util.IbatisUtil;
import kr.go.booktopia.util.StringUtil;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.Criteria;

/**
 * 서적 검색
 * @author JHTA
 *
 */
@WebServlet("/do.book-search")
public class BookSearchServlet extends BaseServlet {
	
	/**
	 * 1. 키워드가 없는 경우 장르만 이용해서 검색한다, 장르만 적용
	 * 2. 키워드가 있을 경우
	 * 2.1 장르가 있을 경우 장르, 키워드, 옵션 모두 적용
	 * 2.2 장르가 없을 경우 키워드 장르만 적용
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.setRequestContentType(req);
		this.setResponseJsonType(res, "text/plain");
		
		String k = req.getParameter("keyword");
		String o = req.getParameter("opt");
		String g = req.getParameter("genre");
		String p = req.getParameter("page");
		String mode = req.getParameter("mode");
		
		Criteria criteria = new Criteria();
		criteria.setPage(Integer.valueOf(p));
		List<Book> bookList = null;
		

		
		Gson gson = new Gson();
		PrintWriter out = res.getWriter();
		try {
			if("latest".equals(mode)) {	// 최신순
				bookList = new BookDao().readLatestBook(criteria);
			} else if ("genreOnly".equals(mode)) {	// 장르만으로 검색
				criteria.setIds(StringUtil.convertStringToIntList(g));
				bookList = DaoManager.getInstance().search(Book.class, criteria);
			} else {	// 키워드 + 장르 검색
				criteria.setIds(StringUtil.convertStringToIntList(g));
				criteria.setKeyword(k);
				criteria.setOpt(o);
				bookList = DaoManager.getInstance().search(Book.class, criteria);
			}
			out.println(gson.toJson(bookList));
		} catch(SQLException ex) {
			throw new ServletException(ex);
		}
		
		
	}
}

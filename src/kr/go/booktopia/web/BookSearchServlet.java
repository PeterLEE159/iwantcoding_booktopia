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
 * ���� �˻�
 * @author JHTA
 *
 */
@WebServlet("/do.book-search")
public class BookSearchServlet extends BaseServlet {
	
	/**
	 * 1. Ű���尡 ���� ��� �帣�� �̿��ؼ� �˻��Ѵ�, �帣�� ����
	 * 2. Ű���尡 ���� ���
	 * 2.1 �帣�� ���� ��� �帣, Ű����, �ɼ� ��� ����
	 * 2.2 �帣�� ���� ��� Ű���� �帣�� ����
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
			if("latest".equals(mode)) {	// �ֽż�
				bookList = new BookDao().readLatestBook(criteria);
			} else if ("genreOnly".equals(mode)) {	// �帣������ �˻�
				criteria.setIds(StringUtil.convertStringToIntList(g));
				bookList = DaoManager.getInstance().search(Book.class, criteria);
			} else {	// Ű���� + �帣 �˻�
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

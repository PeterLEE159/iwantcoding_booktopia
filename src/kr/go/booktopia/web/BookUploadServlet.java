package kr.go.booktopia.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import kr.go.booktopia.dao.BookDao;
import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.util.DateUtil;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.BookGenre;
import kr.go.booktopia.vo.BookPublisher;
import kr.go.booktopia.vo.BookTranslator;
import kr.go.booktopia.vo.BookWriters;

@WebServlet("/adminpage/book/add.jsp")
@MultipartConfig()
public class BookUploadServlet extends BaseServlet {
	
	private static final String SAVED_DIRECTORY = "C:\\web_eclipse\\web_workspace\\booktopia\\WebContent\\images\\book\\";
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");

		String[] genres = req.getParameterValues("genres");

		BookDao bookDao = new BookDao();
		
		Book book = new Book();
		int bookNo;
		try {
			bookNo = bookDao.getBookNextVal();
		
			book.setId(bookNo);
			DaoManager daoManager = DaoManager.getInstance();
	
			String title = req.getParameter("title");
			book.setName(title);
			
			String wId = req.getParameter("writer");
			if ("".equals(wId)) {
				String newWName = req.getParameter("new-writer");
				if ("".equals(newWName)) {
					res.sendRedirect("/adminpage/book/addbook.jsp?fail=1");
					return;
				} 
				BookWriters newWriter = new BookWriters();
				newWriter.setName(newWName);
				daoManager.create(newWriter);	
				int newWId = daoManager.getseq(BookWriters.class);
				newWriter.setId(newWId);		
				book.setWriter(newWriter);
			} else {
				BookWriters writer = new BookWriters();		
				writer.setId(Integer.parseInt(wId));
				book.setWriter(writer);
			}
			
			String tId = req.getParameter("translator");
			if ("".equals(tId)) {
				String newTName = req.getParameter("new-translator");
				if (!"".equals(newTName)) {
					BookTranslator newTranslator = new BookTranslator();	
					newTranslator.setName(newTName);
					daoManager.create(newTranslator);
					int newTId = daoManager.getseq(BookTranslator.class);
					newTranslator.setId(newTId);	
					book.setTranslator(newTranslator);
				}
			} else {
				BookTranslator translator = new BookTranslator();
				translator.setId(Integer.parseInt(tId));
				book.setTranslator(translator);	
			}
			
			String pId = req.getParameter("publisher");
			if ("".equals(pId)) {
				String newPName = req.getParameter("new-publisher");
				if ("".equals(newPName)) {
					res.sendRedirect("/adminpage/book/addbook.jsp?fail=2");
					return;
				}
				BookPublisher newPublisher = new BookPublisher();
				newPublisher.setName(newPName);
				daoManager.create(newPublisher);
				int newPId = daoManager.getseq(BookPublisher.class);
				newPublisher.setId(newPId);
				book.setPublisher(newPublisher);
			} else {
				BookPublisher publisher = new BookPublisher();
				publisher.setId(Integer.parseInt(pId));		
				book.setPublisher(publisher);
			}
	
			String publishDate = req.getParameter("publishdate");
			Date pDate = DateUtil.yyyymmdd(publishDate);
			book.setPublishDate(pDate);	
			
			String bookExplain = req.getParameter("bookexplain");
			book.setContent(bookExplain);			
			
			Part part = req.getPart("bookimages");
			
			if (part != null) {
				
				String filename = System.currentTimeMillis() + getFilename(part);
				long filesize = part.getSize();
				
				part.write(SAVED_DIRECTORY + filename);
				book.setImageUrl(filename);
			}
			
			book.setPreviewUrl("pdf1.pdf");
			daoManager.create(book);
	
			for(String genre : genres){
				BookGenre bookGenre = new BookGenre();
				bookGenre.setBookId(bookNo);
				bookGenre.setGenreId(Integer.parseInt(genre));
				daoManager.create(bookGenre);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		res.sendRedirect("/adminpage/book/addbooklist.jsp");		
		
	}
	
	private String getFilename(Part part) {
		String contentDisposition = part.getHeader("content-disposition");
		// contentDisposition -> form-data; name='f'; filename="commons-codec-1.10.zip"
		String[] items = contentDisposition.split(";");
		for (String item : items) {
			if (item.trim().startsWith("filename")) {
				return item.substring(item.indexOf("=")+2, item.length()-1);
			}
		}
		return null;
	}
}

package kr.go.booktopia.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import kr.go.booktopia.dao.BookDao;
import kr.go.booktopia.util.DateUtil;
import kr.go.booktopia.vo.Book;

@WebServlet("/adminpage/book/update.jsp")

@MultipartConfig()
public class BookFileuploadServlet extends HttpServlet {

	private static final String SAVED_DIRECTORY = "C:\\web_eclipse\\web_workspace\\booktopia\\WebContent\\images\\book\\";
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	
		req.setCharacterEncoding("utf-8");
		
		
		int bookNo = Integer.parseInt(req.getParameter("bookno"));
		String bookTitle = req.getParameter("booktitle");
		Date publishDate = DateUtil.yyyymmdd(req.getParameter("pubdate"));
		String bookContent = req.getParameter("bookintro");
		
		Book book = new Book();
		book.setId(bookNo);
		book.setName(bookTitle);
		book.setContent(bookContent);
		book.setPublishDate(publishDate);
		book.setPreviewUrl("pdf1.pdf");
		Part part = req.getPart("bookimages");
		if(part != null ) {
			
			String filename = System.currentTimeMillis() + getFilename(part);
			long filesize = part.getSize();
			
			part.write(SAVED_DIRECTORY + filename);
			book.setImageUrl(filename);
		}
		
		try {
			new BookDao().bookUpdate(book);
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

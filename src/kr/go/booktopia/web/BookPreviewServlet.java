package kr.go.booktopia.web;

import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;




import kr.go.booktopia.config.Dir;





@WebServlet("/do.book_preview")
public class BookPreviewServlet extends BaseServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	    
	    
	    String pdfName = req.getParameter("previewUrl"); 
		res.setContentType("application/pdf");
		
		// 다운로드 받는 클라이언트 쪽의 파일이름 (attachment로 적용되면 무조건 다운로드)
//		res.setHeader("Content-Disposition", "attachment;filename="+filename);
		res.setHeader("Content-Disposition", "inline;filename="+pdfName);
		
//		resp.addHeader("Content-Disposition", "attachment; filename=Documentation.pdf");
		
		
		String absolutePath = getServletContext().getRealPath("/preview/book/");
	
		
		FileInputStream fis = new FileInputStream(absolutePath + pdfName);
		ServletOutputStream out = res.getOutputStream();
		
		IOUtils.copy(fis, out);
	}
}

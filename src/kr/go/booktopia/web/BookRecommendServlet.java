package kr.go.booktopia.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.vo.BookRecommend;
import kr.go.booktopia.vo.Criteria;
import kr.go.booktopia.vo.Message;

@WebServlet("/do.book_recommend")
public class BookRecommendServlet extends BaseServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		this.setResponseContentType(res);
		
		String userId = req.getParameter("userid");
		String bookId = req.getParameter("bookid");
		Message message = new Message();
		PrintWriter out = res.getWriter();
		Gson gson = new Gson();
		if(userId == null || bookId == null) {
			message.setMessage("userid 와 bookid가 필요합니다");
			message.setStatusCode(-1);
			out.println(gson.toJson(message));
			return;
		}
		DaoManager m = DaoManager.getInstance();
		Criteria c = new Criteria();
		int iuserId = Integer.parseInt(userId);
		int ibookId = Integer.parseInt(bookId); 
		c.setBookId(ibookId);
		c.setUserId(iuserId);
		try {
			List<BookRecommend> recommendList = m.search(BookRecommend.class, c);
			BookRecommend recommend = new BookRecommend();
			if(recommendList.size() == 0) {
				// 추천하기
				recommend.setUserId(iuserId);
				recommend.setBookId(ibookId);
				m.create(recommend);
				message.setMessage("추천하셨습니다");
				message.setStatusCode(1);
			} else {
				recommend = recommendList.get(0);
				if(recommend.getCharIsActive().equals("Y")) {
					// 추천취소하기
					message.setMessage("이미 추천하셨습니다");
					message.setStatusCode(0);
				} else {
					// 추천하기
					recommend.setCharIsActive("Y");
					message.setMessage("추천하셨습니다");
					message.setStatusCode(1);
					m.update(recommend);
				}
				
			}
			out.println(gson.toJson(message));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
			
	}
}

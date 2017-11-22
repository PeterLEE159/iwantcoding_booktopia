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
			message.setMessage("userid �� bookid�� �ʿ��մϴ�");
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
				// ��õ�ϱ�
				recommend.setUserId(iuserId);
				recommend.setBookId(ibookId);
				m.create(recommend);
				message.setMessage("��õ�ϼ̽��ϴ�");
				message.setStatusCode(1);
			} else {
				recommend = recommendList.get(0);
				if(recommend.getCharIsActive().equals("Y")) {
					// ��õ����ϱ�
					message.setMessage("�̹� ��õ�ϼ̽��ϴ�");
					message.setStatusCode(0);
				} else {
					// ��õ�ϱ�
					recommend.setCharIsActive("Y");
					message.setMessage("��õ�ϼ̽��ϴ�");
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

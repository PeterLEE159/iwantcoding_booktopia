package kr.go.booktopia.util;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.codec.digest.DigestUtils;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

import kr.go.booktopia.dao.DaoManager;
import kr.go.booktopia.vo.Announcement;
import kr.go.booktopia.vo.BaseVo;
import kr.go.booktopia.vo.Board;
import kr.go.booktopia.vo.BoardComment;
import kr.go.booktopia.vo.Book;
import kr.go.booktopia.vo.BookBooking;
import kr.go.booktopia.vo.BookComment;
import kr.go.booktopia.vo.BookGenre;
import kr.go.booktopia.vo.BookPublisher;
import kr.go.booktopia.vo.BookRecommend;
import kr.go.booktopia.vo.BookRental;
import kr.go.booktopia.vo.BookRentalPenalty;
import kr.go.booktopia.vo.BookTranslator;
import kr.go.booktopia.vo.BookWish;
import kr.go.booktopia.vo.BookWriters;
import kr.go.booktopia.vo.BookWriters;
import kr.go.booktopia.vo.Genre;
import kr.go.booktopia.vo.Question;
import kr.go.booktopia.vo.QuestionAnswer;
import kr.go.booktopia.vo.User;

public class IbatisUtil {
	private static SqlMapClient dbClient;
	
	static {
		try {
			Reader reader = Resources.getResourceAsReader("kr/go/booktopia/config/SqlMapConfig.xml");
			dbClient = SqlMapClientBuilder.buildSqlMapClient(reader);
		} catch(Exception ex ) {
			ex.printStackTrace();
		}
	}
	
	public static SqlMapClient getClient() {
		return dbClient;
	}
	public static <T extends BaseVo> List<Integer> convertIdsToIntergerList(List<T> list) {
		List<Integer> result = new ArrayList<>();
		for(BaseVo vo : list) {
			result.add(vo.getId());
		}
		return result;
	}
	
	
	public static void insertDummy() {
	      try {
	         
	         DaoManager m = DaoManager.getInstance();
	         Random random = new Random();
	         String[] lastName = {"ȫ", "��", "��", "��", "��", "��", "��", "Ȳ", "��", "��", "��", "õ", "��" };
	         String[] firstName = {"����", "����", "����", "����", "����", "�α�", "����", "��ȭ", "�Թ�", "����", "��ȭ", "����", "��ȯ",
	               "��ȯ", "��ȫ", "�μ�", "���", "�ֿ�", "�μ�", "����", "����", "����", "����", "����", "����", "��ȭ", "ȿ��", "����"};
	         int size = 100;
	         String[] imagePath = {"image1.jpg", "image2.jpg", "image3.jpg", "image4.jpg", "image5.jpg", "image6.jpg", 
	        		 "image7.jpg", "image8.jpg", "image9.jpg", "image10.jpg", "image11.jpg"};
	         String[] prePublisherName = {"��õ��", "�з��Ͼ�", "ģ��", "�޻�", "����", "�ѱ�", "��", "��ȭ", "����", "����", "���"};
	         String[] postPublisherName = {" ����", " �̵��", " �Ű���", " ���", " ���", " ����", " ����", " ����", " ���۷���", " �̳뺣�̼�"}; 
	         String[] preBooks = {"������ ", "���ּ� ", "������ ", "������ ", "������� ", "������ ���� ��ż�� ", "��å���� ", "������ ", "��Ƽ�þƴ� ", "������ ",
	        		 "�츮���� ", "�����ʹ� ", "�������� ", "����ġ�� ", "������ ", "������ "};
	         String[] postBooks = {"���", "����", "����", "��Ż", "����", "�뿩", "����", "��ĥ", "����", "�ڿ�", "����", "����", "����Ʈ"};
	         String[] password = new String[lastName.length];
	         for (int i=0; i< lastName.length; i++){
	            password[i] = DigestUtils.sha256Hex(lastName[i]);
	         }
	         
	         String[] preEmail = {"lw098", "hw19208", "ao1051", "op19823", "owner", "operational", "show123", "me", "the19823", "monett11",
	               "iop1908", "doubleQ123", "singlePop123", "letter1251","ching155", "nomore19085", "ohhLove"};
	         String[] email = {"gmail.com", "naver.com", "hanmail.com"};
	         String[] phone = {"01012367543", "01061267234", "01073443473", "01016751067", "01061675123", "01069531023",
	               "01060986012", "01056913561", "01051023819", "01059193958", "01020396812" };
	         
	         String[] title = { "���� ó�� �λ�帳�ϴ�", "���� �����Դϴ� ^^", "�� ���ó��� ���� ��������", "���������� ���� �ؾ���Ƚ��ϴ�",
	               "���� �����ΰ� ����� ����ΰ�", "�������� �����ǳ� �����ұ�", "���� �ٻ��ϰ� ���� ������ ġŲ", "�Ż� ������ �� ����� �峭���׿�" };
	         String[] contents = {"���� ���� ���Ἲ ���� ������ ����ϸ� ���� �ܷ� Ű�� ����Ű�� Ű�� ����ڰ� ���� �Ǵ� ������Ʈ�Ϸ� �� �� SQL Server���� ������ �۾��� ������ �� �ֽ��ϴ�. CREATE TABLE �� ALTER TABLE ���� REFERENCES ������ ON DELETE �� ON UPDATE ���� ����� �� �ֽ��ϴ�. �ܷ� Ű ���� ��ȭ ���ڸ� ����Ͽ� ���� �۾��� ������ ���� �ֽ��ϴ�",
	                     "�״� '6�� �ٽ����� ���� ������ ��ź���� ����ȭ���淮ȭ ���迡 �����ߴٰ� ������'�� ������ �����ź���̻���(ICBM)���� �� �� �ִٰ� �Ǵ��Ѵٰ� ���ߴ�",
	                     "���ε� Ʈ���� ������� �� �����ΰ� ������ �� �ִ� �ɼ� ��� �ϳ��� �ٷ� Ư�������δ�(Ư�ۺδ�)�� ������ ��3���� �ٹ��� ����ȭ �õ� �����̴�",
	                     "�̷� ��ȭ�� ��ӽ� ���̸յ� SOCOM ��ɰ��� 5�� 2��(�����ð�) �Ͽ� û��ȸ �߾𿡼� �� ��Ÿ����. ��ӽ� ��ɰ��� �ѹݵ� ����� �̱��� ������ �١��̻��ϰ� ȭ�й��� �� WMD �ü��� Ÿ���� ����ȭ��ų �غ� �� �ִٸ鼭, Ư�ۺδ밡 �� �ӹ� ���� �������� ���� ������ �� ���̶�� ������",
	                     "WMD Ȯ�� ���� �� ����ȭ �ӹ��� 1992�� �ҷ� �ر��� �Բ� �ο��ƴٴ� �� �����̴�. �ҷ� ��ü �������� ���� ���� ��ȭ���� ��ġ�� �����ٹ���� ������ �ʿ��� �ٹ����� �ֿ� ��ġ�鿡 ���� ������ ����������. �� ƴ�� Ÿ '��Ȯõ��'�� �븰 �� �强�� ������ ���� �����׷�������� ��Ź�� �̸� ������ �� ��и��� ����Ǳ� �����ߴ�",
	                     "���� ��� �ҷð� �߱� ���� ���� WMD �ü� Ÿ�� �ӹ��� ����ϴ� �׸�����(���� Ư����) �� �Ϻ� Ư�ۺδ������ ������ �ٹ���� ��ȭ�й��� ���� '�ҹ�����'�� �����ϴ� ���Ȱ����� ���� ���̴�",
	                     "WMD ���� �ӹ��� ���� ����ȭ�� Ư�ۺδ밡 �յ�Ư������ɺ�(JSOC)��. �ߵ��� �׷������̳� �������� �ҹ� ����� �̱��� ���� ���� �� ���׷� �ӹ��� �ַ� �����ؿ� JSOC�� �ٽ� �����δ밡 '����׷�'(DevGru. �� ���̺�� 6��)�� '��Ÿ����'��. �� ��� ����׷�� ���� �׷����� ��ī������ â���� ���縶 ����� ����� ����������",
	                     "���ƽþ� ���� �������� ������ ���̽� �� �̵麣�� �������������� �Ҽ� ���� ������ �� �������� ���� JSOC�� �߽����� �ϴ� �� Ư�ۺδ밡 ���� �� ���� �ӹ��� ����� �����Ϸ��� ��Ȯ�� ����� ��� ���� ���� ������ ���� ������ Ȯ�� ����� �ʿ��ϴٰ� ������"};
	      
	         String comments[] = {"�̰��� �ֵ��� ȿ���� ã�ư����� �ʾҾ ȿ���� �ι�2�� �� ���� �־����ٵ� ¥������",
	               "ȿ���� �ι��� ��¥ ������ �ϴ�",
	               "ȿ���׹ι�, �˾������� ��Ÿ���� �ٸ����� �ְ���",
	               "ȿ���� �ι� ��¥ �����̰� ������ ��",
	               "�̹��� ��ȿ���� �������� ������ ������~ ǳ���� ����ִµ�~ �ٴٰ� ��~�� ���϶� ���� �𸣰� ���� ���� �������ٴ�~ ������ ȭ~�� Ʈ����~ ������ �Ǹ鼭 ���Ҿ�� ^^",
	               "ȿ���״� ��¥ �ż����� ��ȿ���� �ٽú�",
	               "ȿ���� ����",
	               "���� ���� �����ε� ���ֽ��ϴ�!!!!",
	               "�̷� �ְ� ��û���� ���� �ϴµ�.",
	               "�ٸ� �����Ӹ� �ܱ��ε��! �ÿ����� ���� �����!!",
	               "�뷡 ���� ������",
	               "�� �������� Ʈ��Ʈ ��¦ ���� �ƴ϶�... �� ���� ����� ���ΰ��� �Ǿ����... Ŭ������ �ٸ���... �������... �� ��Ÿ����."};
	         
	         
	         // ����, å ����, å ����
	         for(int i=0; i< size;i++) {
	            User u = new User();
	            u.setName(lastName[random.nextInt(lastName.length)]+firstName[random.nextInt(firstName.length)]);
	            u.setUserId(preEmail[random.nextInt(preEmail.length)]);
	            u.setEmail(preEmail[random.nextInt(preEmail.length)]+"@"+email[random.nextInt(email.length)]);
	            u.setPassword(password[random.nextInt(password.length)]);
	            u.setPhone(phone[random.nextInt(phone.length)]);
	            m.create(u);
	            
	            BookTranslator t =new BookTranslator();
	            t.setName(lastName[random.nextInt(lastName.length)]+firstName[random.nextInt(firstName.length)]);
	            t.setEmail(preEmail[random.nextInt(preEmail.length)]+"@"+email[random.nextInt(email.length)]);
	            t.setPhone(phone[random.nextInt(phone.length)]);
	            m.create(t);
	            
	            BookWriters w = new BookWriters();
	            w.setName(lastName[random.nextInt(lastName.length)]+firstName[random.nextInt(firstName.length)]);
	            w.setEmail(preEmail[random.nextInt(preEmail.length)]+"@"+email[random.nextInt(email.length)]);
	            w.setPhone(phone[random.nextInt(phone.length)]);
	            m.create(w);
	         }
	         
	         // ���ǻ�
	         for(int i=0; i< size;i++) {
	            BookPublisher p =new BookPublisher();
	            p.setName(prePublisherName[random.nextInt(prePublisherName.length)]+postPublisherName[random.nextInt(postPublisherName.length)]);
	            p.setEmail(preEmail[random.nextInt(preEmail.length)]+"@"+email[random.nextInt(email.length)]);
	            p.setPhone(phone[random.nextInt(phone.length)]);
	            m.create(p);
	         }
//	         
	         // �������� ����
	         for(int i=0; i< size; i++) {
	            Announcement v = new Announcement();
	            
	            User admin = new User();
	            admin.setId(random.nextInt(size) + 1);
	            
	            v.setAdmin(admin);
	            v.setCharIsEmergency(random.nextInt(5) == 1 ? "Y" : "N");
	            v.setTitle(title[random.nextInt(title.length)]);
	            v.setContent(contents[random.nextInt(contents.length)]);
	            m.create(v);
	         }
	         
	         // �Խ���
	         for(int i=0; i< size; i++) {
	            Board b = new Board();
	            User user = new User();
	            user.setId(random.nextInt(size) + 1);
	            
	            b.setUser(user);
	            b.setTitle(title[random.nextInt(title.length)]);
	            b.setContent(contents[random.nextInt(contents.length)]);
	            m.create(b);
	         }
	         // ���
	         for(int i=0; i< size * 3; i++) {
	            BoardComment c = new BoardComment();
	            User user = new User();
	            Board b = new Board();
	            b.setId(random.nextInt(size) + 1);
	            user.setId(random.nextInt(size) + 1);
	            
	            c.setUser(user);
	            c.setBoard(b);
	            
	            c.setContent(contents[random.nextInt(contents.length)]);
	            m.create(c);
	         }
	         
	         // å
	         for(int i=0; i< size; i++) {
	            Book b = new Book();
	            User user = new User();
	            user.setId(random.nextInt(size) + 1);
	            b.setName(preBooks[random.nextInt(preBooks.length)]+postBooks[random.nextInt(postBooks.length)]);
	            b.setContent(contents[random.nextInt(contents.length)]);
	            b.setImageUrl(imagePath[random.nextInt(contents.length)]);
	            b.setStrRental(random.nextInt(3) == 0 ? "Y" : "N" );
	            b.setPreviewUrl(random.nextInt(2)%2 == 0 ? "pdf1.pdf" : "pdf2.pdf");
	            b.setPublishDate(new Date());
	            
	            BookPublisher p = new BookPublisher();
	            p.setId(random.nextInt(size) + 1);
	            b.setPublisher(p);
	            BookWriters w = new BookWriters();
	            w.setId(random.nextInt(size) + 1);
	            b.setWriter(w);
	            BookTranslator t = new BookTranslator();
	            t.setId(random.nextInt(size) + 1);
	            b.setTranslator(t);
	            m.create(b);
	         }
	         
	         // å ���
	         for(int i=0; i< size; i++) {
	            BookComment c = new BookComment();
	            Book b = new Book();
	            User u = new User();
	            b.setId(random.nextInt(size) + 1);
	            u.setId(random.nextInt(size) + 1);
	            
	            c.setBook(b);
	            c.setContent(contents[random.nextInt(contents.length)]);
	            c.setRatingPoint(random.nextInt(6));
	            c.setUser(u);
	            m.create(c);
	         }
	         
	         
	         
	         // å - �帣 ���� ���̺�
	         for(int i=0; i< size*1.5; i++) {
	            BookGenre r = new BookGenre();
	            r.setBookId(random.nextInt(size) + 1);
	            r.setGenreId(random.nextInt(8) + 1);
	            m.create(r);
	         }
	         
	         // �帣 ���̺�
	         String[] type = {"IT", "����Ҽ�", "����", "�����Ҽ�", "ö��", "����", "����", "����"};
	         for(int i=0; i< 8 ;i++) {
	            Genre genre = new Genre();
	            genre.setType(type[i]);
	            m.create(genre);
	         }
	         

	         
	         // å ��õ
	         // å �뿩
	         // å �뿩 �䳯Ƽ
	         for(int i=0; i< size*3; i++) {
	        	 BookBooking b = new BookBooking();
	        	 BookRental r = new BookRental();
	        	 BookRentalPenalty p = new BookRentalPenalty();
	        	 BookRecommend re = new BookRecommend(); 
	        	 Book book = new Book();
	        	 User user = new User();
	        	 book.setId(random.nextInt(size) + 1);
	        	 user.setId(random.nextInt(size) + 1);
	        	 
	        	 b.setUserId(random.nextInt(size) + 1);
	        	 b.setBook(book);
	        	 r.setBook(book);
	        	 r.setUser(user);
	        	 re.setBookId(random.nextInt(size) + 1);
	        	 re.setUserId(random.nextInt(size) + 1);
	        	 if(i < size / 5) {
		        	 p.setDelayDate(random.nextInt(60) + 1);
		        	 p.setUser(user);
		        	 m.create(p);
		        	 m.create(r);
	        	 }
	        	 m.create(b);
	        	 m.create(re);
	         }
	         
	         // �������
	         // ����
	         // ������ ���� �亯
	         for(int i=0; i< size / 2; i++) {
	        	 BookWish w = new BookWish();
	        	 User user = new User();
	        	 Question q = new Question();
	        	 QuestionAnswer a = new QuestionAnswer();
	        	 user.setId(random.nextInt(size) + 1);
	        	 w.setBookName(preBooks[random.nextInt(preBooks.length)] + postBooks[random.nextInt(postBooks.length)]);
	        	 w.setWriter(lastName[random.nextInt(lastName.length)]+firstName[random.nextInt(firstName.length)]);
	        	 w.setPublisher(prePublisherName[random.nextInt(prePublisherName.length)]+postPublisherName[random.nextInt(postPublisherName.length)]);
	        	 w.setUser(user);
	        	 
	        	 q.setTitle(title[random.nextInt(title.length)]);
		         q.setContent(contents[random.nextInt(contents.length)]);
	        	 q.setViewCount(random.nextInt(size) + 1);
	        	 q.setUser(user);
	        	 
	        	 
		         a.setContent(contents[random.nextInt(contents.length)]);
	        	 a.setQuestionId(random.nextInt(size) + 1);
	        	 a.setAdmin(user);
	        	 m.create(w);
	        	 m.create(q);
	        	 m.create(a);
	         }
	         
	         
	         
	         
	         
	         
	         
	         
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	   }
}


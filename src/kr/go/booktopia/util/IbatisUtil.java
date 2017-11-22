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
	         String[] lastName = {"홍", "박", "김", "이", "남", "서", "태", "황", "석", "문", "지", "천", "설" };
	         String[] firstName = {"진후", "석태", "진서", "나은", "진희", "민규", "형택", "석화", "규민", "성우", "설화", "민지", "승환",
	               "성환", "재홍", "인선", "대녕", "주원", "민서", "은경", "은지", "은하", "석주", "진선", "나은", "선화", "효선", "구선"};
	         int size = 100;
	         String[] imagePath = {"image1.jpg", "image2.jpg", "image3.jpg", "image4.jpg", "image5.jpg", "image6.jpg", 
	        		 "image7.jpg", "image8.jpg", "image9.jpg", "image10.jpg", "image11.jpg"};
	         String[] prePublisherName = {"새천년", "밀레니엄", "친구", "햇살", "정독", "한국", "새", "진화", "서울", "종로", "어린이"};
	         String[] postPublisherName = {" 나눔", " 미디어", " 매거진", " 사랑", " 희망", " 나눔", " 공유", " 현대", " 컨퍼런스", " 이노베이션"}; 
	         String[] preBooks = {"개미의 ", "우주선 ", "항행의 ", "무소유 ", "어린왕자의 ", "마당을 나온 암탉의 ", "산책자의 ", "오늘은 ", "레티시아는 ", "설명의 ",
	        		 "우리집은 ", "흡혈귀는 ", "마광수의 ", "전우치의 ", "문명의 ", "전쟁은 "};
	         String[] postBooks = {"욕망", "자유", "여행", "일탈", "소유", "대여", "역사", "색칠", "선물", "자연", "설명", "컨셉", "베스트"};
	         String[] password = new String[lastName.length];
	         for (int i=0; i< lastName.length; i++){
	            password[i] = DigestUtils.sha256Hex(lastName[i]);
	         }
	         
	         String[] preEmail = {"lw098", "hw19208", "ao1051", "op19823", "owner", "operational", "show123", "me", "the19823", "monett11",
	               "iop1908", "doubleQ123", "singlePop123", "letter1251","ching155", "nomore19085", "ohhLove"};
	         String[] email = {"gmail.com", "naver.com", "hanmail.com"};
	         String[] phone = {"01012367543", "01061267234", "01073443473", "01016751067", "01061675123", "01069531023",
	               "01060986012", "01056913561", "01051023819", "01059193958", "01020396812" };
	         
	         String[] title = { "오늘 처음 인사드립니다", "좋은 날씨입니다 ^^", "와 오늘날씨 완전 가을가을", "도서관에서 폰을 잊어버렸습니다",
	               "나는 누구인가 여기는 어디인가", "괌에가서 모히또나 한잔할까", "겉은 바삭하고 안은 촉촉한 치킨", "신상 갤럭시 폰 기능이 장난없네요" };
	         String[] contents = {"연계 참조 무결성 제약 조건을 사용하면 기존 외래 키가 가리키는 키를 사용자가 삭제 또는 업데이트하려 할 때 SQL Server에서 수행할 작업을 정의할 수 있습니다. CREATE TABLE 및 ALTER TABLE 문의 REFERENCES 절에는 ON DELETE 및 ON UPDATE 절을 사용할 수 있습니다. 외래 키 관계 대화 상자를 사용하여 연계 작업을 정의할 수도 있습니다",
	                     "그는 '6차 핵실험을 통해 북한이 핵탄두의 소형화·경량화 실험에 성공했다고 보느냐'는 물음엔 대륙간탄도미사일(ICBM)에는 들어갈 수 있다고 판단한다고 답했다",
	                     "도널드 트럼프 대통령의 미 행정부가 선택할 수 있는 옵션 가운데 하나가 바로 특수작전부대(특작부대)를 동원한 제3국의 핵무기 무력화 시도 작전이다",
	                     "이런 변화는 토머스 레이먼드 SOCOM 사령관의 5월 2일(현지시간) 하원 청문회 발언에서 잘 나타난다. 토머스 사령관은 한반도 유사시 미군은 북한의 핵·미사일과 화학무기 등 WMD 시설을 타격해 무력화시킬 준비가 돼 있다면서, 특작부대가 이 임무 수행 과정에서 선봉 역할을 할 것이라고 밝혔다",
	                     "WMD 확산 차단 등 무력화 임무는 1992년 소련 붕괴와 함께 부여됐다는 게 정설이다. 소련 해체 과정에서 여러 산하 공화국에 배치된 전술핵무기와 제조에 필요한 핵물질과 주요 장치들에 대한 관리가 느슨해졌다. 이 틈을 타 '일확천금'을 노린 군 장성과 과학자 등이 국제테러조직들과 결탁해 이를 빼돌린 후 비밀리에 유통되기 시작했다",
	                     "냉전 당시 소련과 중국 등의 관련 WMD 시설 타격 임무를 담당하던 그린베레(육군 특전단) 등 일부 특작부대원들이 이제는 핵무기와 생화학무기 등의 '불법유통'을 방지하는 보안관으로 나선 셈이다",
	                     "WMD 제거 임무에 가장 최적화된 특작부대가 합동특수전사령부(JSOC)다. 중동권 테러조직이나 적성국에 불법 억류된 미국인 인질 구출 등 대테러 임무를 주로 수행해온 JSOC의 핵심 작전부대가 '데브그루'(DevGru. 옛 네이비실 6팀)와 '델타포스'다. 이 가운데 데브그루는 국제 테러조직 알카에다의 창시자 오사마 빈라덴을 사살해 유명해졌다",
	                     "동아시아 군축 전문가인 제프리 루이스 미 미들베리 국제문제연구소 소속 선임 연구원 등 전문가들 역시 JSOC를 중심으로 하는 미 특작부대가 북한 핵 저거 임무를 제대로 수행하려면 비확산 경험과 결과 관리 경험 축적을 위한 전문성 확대 노력이 필요하다고 밝혔다"};
	      
	         String comments[] = {"미개한 애들이 효리네 찾아가지만 않았어도 효리네 민박2도 볼 수도 있얼을텐데 짜증난다",
	               "효리네 민박은 진짜 받을만 하다",
	               "효리네민박, 알쓸신잡이 스타일은 다르지만 최고였음",
	               "효리네 민박 진짜 꿀잼이고 힐링됨 ㅠ",
	               "이번주 이효리와 아이유가 오름에 오를때~ 풍경을 찍어주는데~ 바다가 쫘~악 보일때 나도 모르게 깊은 숨을 내쉬었다는~ 숨통이 화~악 트였당~ 힐링이 되면서 좋았어요 ^^",
	               "효리네는 진짜 신선했음 이효리도 다시봄",
	               "효리유 굳굳",
	               "정말 힘들 결정인데 멋있습니다!!!!",
	               "이런 애가 엄청나게 떠야 하는데.",
	               "다른 검은머리 외국인들아! 택연이좀 보고 배워라!!",
	               "노래 정말 좋더라",
	               "아 돌리고같은 트로트 뽕짝 댄스가 아니라... 이 곡이 결승전 주인공이 되었어야... 클래스가 다른데... 가사부터... 아 안타깝다."};
	         
	         
	         // 유저, 책 저자, 책 역자
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
	         
	         // 출판사
	         for(int i=0; i< size;i++) {
	            BookPublisher p =new BookPublisher();
	            p.setName(prePublisherName[random.nextInt(prePublisherName.length)]+postPublisherName[random.nextInt(postPublisherName.length)]);
	            p.setEmail(preEmail[random.nextInt(preEmail.length)]+"@"+email[random.nextInt(email.length)]);
	            p.setPhone(phone[random.nextInt(phone.length)]);
	            m.create(p);
	         }
//	         
	         // 공지사항 더미
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
	         
	         // 게시판
	         for(int i=0; i< size; i++) {
	            Board b = new Board();
	            User user = new User();
	            user.setId(random.nextInt(size) + 1);
	            
	            b.setUser(user);
	            b.setTitle(title[random.nextInt(title.length)]);
	            b.setContent(contents[random.nextInt(contents.length)]);
	            m.create(b);
	         }
	         // 댓글
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
	         
	         // 책
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
	         
	         // 책 댓글
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
	         
	         
	         
	         // 책 - 장르 연결 테이블
	         for(int i=0; i< size*1.5; i++) {
	            BookGenre r = new BookGenre();
	            r.setBookId(random.nextInt(size) + 1);
	            r.setGenreId(random.nextInt(8) + 1);
	            m.create(r);
	         }
	         
	         // 장르 테이블
	         String[] type = {"IT", "현대소설", "종교", "고전소설", "철학", "교육", "문학", "경제"};
	         for(int i=0; i< 8 ;i++) {
	            Genre genre = new Genre();
	            genre.setType(type[i]);
	            m.create(genre);
	         }
	         

	         
	         // 책 추천
	         // 책 대여
	         // 책 대여 페날티
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
	         
	         // 희망도서
	         // 질문
	         // 질문에 대한 답변
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


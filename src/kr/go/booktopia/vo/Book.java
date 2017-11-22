package kr.go.booktopia.vo;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import kr.go.booktopia.config.Dir;
import kr.go.booktopia.util.StringUtil;

public class Book extends BaseVo {

	private String name;
	private String content;
	private String imageUrl;
	private String fullImageUrl;
	private String previewUrl;
	private String fullPreviewUrl;
	private String strRental;
	private String genre;
	private Date publishDate;
	private BookPublisher publisher;
	private BookWriters writer;
	private BookTranslator translator;
	private int viewCount;
	private int rentalCount;
	private int recommendCount;
	private BookComment[] comments;
	private String rental;
	private double ratingPoint;
	private BookRental lastestBookRental;
	
	
	
	public String getGenre() {
		return genre;
	}


	public void setGenre(String genre) {
		this.genre = genre;
		if(StringUtil.isEmpty(this.genre))
			this.genre = "";
		else
			this.genre = this.genre.substring(0, this.genre.length() - 2);
	}


	public String getStrRental() {
		return strRental;
	}
	
	
	public double getRatingPoint() {
		return ratingPoint;
	}



	public void setRatingPoint(double ratingPoint) {
		this.ratingPoint = ratingPoint;
	}



	public int getRentalCount() {
		return rentalCount;
	}

	public void setRentalCount(int rentalCount) {
		this.rentalCount = rentalCount;
	}

	public void setStrRental(String strRental) {
		this.strRental = strRental;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
		this.fullImageUrl = Dir.dirBookImage + imageUrl;
	}

	public String getPreviewUrl() {
		return previewUrl;
	}

	public void setPreviewUrl(String previewUrl) {
		this.previewUrl = previewUrl;
		this.fullPreviewUrl = Dir.dirBookPreview + imageUrl;
	}

	public Date getPublishDate() {
		return publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}

	public BookPublisher getPublisher() {
		return publisher;
	}

	public void setPublisher(BookPublisher publisher) {
		this.publisher = publisher;
	}

	public BookWriters getWriter() {
		return writer;
	}

	public void setWriter(BookWriters writer) {
		this.writer = writer;
	}

	public BookTranslator getTranslator() {
		return translator;
	}

	public void setTranslator(BookTranslator translator) {
		this.translator = translator;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getRental() {
		return rental;
	}

	public void setRental(String rental) {
		this.rental = rental;
	}

	public BookComment[] getComments() {
		return comments;
	}

	public void setComments(BookComment[] comments) {
		this.comments = comments;
	}

	public String getFullImageUrl() {
		return fullImageUrl;
	}

	public void setFullImageUrl(String fullImageUrl) {
		this.fullImageUrl = fullImageUrl;
	}

	public String getFullPreviewUrl() {
		return fullPreviewUrl;
	}

	public void setFullPreviewUrl(String fullPreviewUrl) {
		this.fullPreviewUrl = fullPreviewUrl;
	}

	public String getRentalFormat() {
		if ("Y".equals(rental)) {
			return "대여중";
		} else {
			return "반납완료";
		}
	}
	
	public int getRecommendCount() {
		return recommendCount;
	}

	public void setRecommendCount(int recommendCount) {
		this.recommendCount = recommendCount;
	}

	public BookRental getLastestBookRental() {
		return lastestBookRental;
	}


	public void setLastestBookRental(BookRental lastestBookRental) {
		this.lastestBookRental = lastestBookRental;
	}

	@Override
	public String toString() {
		return String.format(
				"Book [name=%s, content=%s, imageUrl=%s, fullImageUrl=%s, previewUrl=%s, fullPreviewUrl=%s, strRental=%s, genre=%s, publishDate=%s, publisher=%s, writer=%s, translator=%s, viewCount=%s, rentalCount=%s, recommendCount=%s, comments=%s, rental=%s, ratingPoint=%s, lastestBookRental=%s, id=%s, charIsActive=%s, createdAt=%s, updatedAt=%s]",
				name, content, imageUrl, fullImageUrl, previewUrl, fullPreviewUrl, strRental, genre, publishDate,
				publisher, writer, translator, viewCount, rentalCount, recommendCount, Arrays.toString(comments),
				rental, ratingPoint, lastestBookRental, id, charIsActive, createdAt, updatedAt);
	}
}

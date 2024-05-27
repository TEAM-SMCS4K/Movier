package cs.sookmyung.movier.model;

import java.util.Date;

public class MyPageReviewList extends Review {
    private String posterImg;
    private String title;

    public MyPageReviewList(int reviewId, int memberId, int movieId, double reviewRating, String reviewContent, Date reviewCreatedAt, String posterImg, String title) {
        super(reviewId, memberId, movieId, reviewRating, reviewContent, reviewCreatedAt);
        this.posterImg = posterImg;
        this.title = title;
    }

    public String getPosterImg() {
        return posterImg;
    }

    public String getTitle() {
        return title;
    }
}

package cs.sookmyung.movier.model;

import java.util.Date;

public class MyPageReview extends Review {
    private String posterImg;
    private String title;

    public MyPageReview(int reviewId, int memberId, int movieId, double reviewRating, String reviewContent, Date reviewCreatedAt, String posterImg, String title) {
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

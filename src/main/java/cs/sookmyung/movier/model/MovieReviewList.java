package cs.sookmyung.movier.model;

import java.util.Date;

public class MovieReviewList extends Review{
    private String reviewerName;
    private int sympathyCount;

    public MovieReviewList(int reviewId, int memberId, int movieId, double reviewRating, String reviewContent, Date reviewCreatedAt, String reviewerName, int sympathyCount){
        super(reviewId, memberId, movieId, reviewRating, reviewContent, reviewCreatedAt);
        this.reviewerName = reviewerName;
        this.sympathyCount = sympathyCount;
    }
}

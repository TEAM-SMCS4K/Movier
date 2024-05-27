package cs.sookmyung.movier.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Review {
    private int reviewId;
    private int memberId;
    private int movieId;
    private double reviewRating;
    private String reviewContent;
    private Date reviewCreatedAt;

    public Review(int memberId, int movieId, double reviewRating, String reviewContent, Date reviewCreatedAt) {
        this.memberId = memberId;
        this.movieId = movieId;
        this.reviewRating = reviewRating;
        this.reviewContent = reviewContent;
        this.reviewCreatedAt = reviewCreatedAt;
    }

    public Review(int reviewId, int memberId, int movieId, double reviewRating, String reviewContent, Date reviewCreatedAt) {
        this.reviewId = reviewId;
        this.memberId = memberId;
        this.movieId = movieId;
        this.reviewRating = reviewRating;
        this.reviewContent = reviewContent;
        this.reviewCreatedAt = reviewCreatedAt;
    }

    public int getReviewId() {
        return reviewId;
    }

    public int getMemberId() {
        return memberId;
    }

    public int getMovieId() {
        return movieId;
    }

    public double getReviewRating() {
        return reviewRating;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public Date getReviewCreatedAt() {
        return reviewCreatedAt;
    }

    public String getFormattedReviewCreatedAt() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(reviewCreatedAt);
    }
}

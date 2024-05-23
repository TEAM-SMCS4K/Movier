package cs.sookmyung.movier.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Review {
    private int reviewId;
    private String posterImg;
    private String title;
    private double rating;
    private String reviewContent;
    private Date reviewCreatedAt;

    public Review(int reviewId, String posterImg, String title, double rating, String reviewContent, Date reviewCreatedAt) {
        this.reviewId = reviewId;
        this.posterImg = posterImg;
        this.title = title;
        this.rating = rating;
        this.reviewContent = reviewContent;
        this.reviewCreatedAt = reviewCreatedAt;
    }

    public int getReviewId() {
        return reviewId;
    }

    public String getPosterImg() {
        return posterImg;
    }

    public String getTitle() {
        return title;
    }

    public double getRating() {
        return rating;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public String getFormattedReviewCreatedAt() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(reviewCreatedAt);
    }
}

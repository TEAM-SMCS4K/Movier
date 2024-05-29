package cs.sookmyung.movier.model;

import java.util.Date;

public class ReviewDetail extends Review {
    private String thumbnailImg;

    public ReviewDetail(int reviewId, int movieId, double reviewRating, String reviewContent, String thumbnailImg) {
        super(reviewId, 0, movieId, reviewRating, reviewContent, new Date());
        this.thumbnailImg = thumbnailImg;
    }

    public String getThumbnailImg() {
        return thumbnailImg;
    }
}

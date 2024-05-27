package cs.sookmyung.movier.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ReviewDetail extends MyPageReview{
    private String genre;
    private Date releaseDate;
    private int runningTime;

    public ReviewDetail(int reviewId, int memberId, int movieId, double reviewRating, String reviewContent, Date reviewCreatedAt, String posterImg, String title, String genre, Date releaseDate, int runningTime) {
        super(reviewId, memberId, movieId, reviewRating, reviewContent, reviewCreatedAt, posterImg, title);
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.runningTime = runningTime;
    }

    public String getGenre() {
        return genre;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public int getRunningTime() {
        return runningTime;
    }

    public String getFormattedReleaseDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        return formatter.format(releaseDate);
    }
}

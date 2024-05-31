package cs.sookmyung.movier.model;

public class MovieList {
    private int id;
    private String title;
    private String posterImg;
    private double rating;
    private int review_count;

    public MovieList(int id, String title, String posterImg, double rating, int review_count) {
        this.id = id;
        this.title = title;
        this.posterImg = posterImg;
        this.rating = rating;
        this.review_count = review_count;
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getPosterImg() {
        return posterImg;
    }

    public double getRating() {
        return rating;
    }

    public int getReview_count() {
        return review_count;
    }
}
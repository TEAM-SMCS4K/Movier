package cs.sookmyung.movier.model;

public class MovieList {
    private int id;
    private String title;
    private String posterImg;
    private double rating;

    public MovieList(int id, String title, String posterImg, double rating) {
        this.id = id;
        this.title = title;
        this.posterImg = posterImg;
        this.rating = rating;
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
}
package cs.sookmyung.movier.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Movie {
    private int id;
    private String title;
    private String posterImg;
    private String thumbnailImg;
    private String genre;
    private Date releaseDate;
    private int runningTime;
    private String plot;

    public Movie(int id, String title, String posterImg, String thumbnailImg, String genre, Date releaseDate, int runningTime, String plot) {
        this.id = id;
        this.title = title;
        this.posterImg = posterImg;
        this.thumbnailImg = thumbnailImg;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.runningTime = runningTime;
        this.plot = plot;
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

    public String getThumbnailImg() {
        return thumbnailImg;
    }

    public String getGenre() {
        return genre;
    }

    public String getReleaseDateAndRunningTime() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
        String formattedDate = formatter.format(releaseDate);
        return formattedDate + " | " + runningTime + "분";
    }

    public String getPlot() {
        return plot;
    }
}

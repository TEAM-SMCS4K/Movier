package cs.sookmyung.movier.model;

public class MovieReviewInfo {
    private double ratingAverage;
    private int reviewCount;

    public MovieReviewInfo(double ratingAverage, int reviewCount) {
        this.ratingAverage = ratingAverage;
        this.reviewCount = reviewCount;
    }

    public double getRatingAverage() {
        return ratingAverage;
    }

    public String getReviewCount() {
        if(reviewCount > 100){
            return "(100+)";
        }
        return "("+reviewCount+")";
    }
}

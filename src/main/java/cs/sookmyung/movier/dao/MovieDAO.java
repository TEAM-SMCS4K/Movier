package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Movie;
import cs.sookmyung.movier.model.MovieReviewInfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MovieDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");

    // 싱글톤 인스턴스를 저장할 정적 변수
    private static MovieDAO instance;

    // private 생성자를 통해 외부에서의 인스턴스 생성을 방지
    private MovieDAO() {}

    // 싱글톤 인스턴스를 반환하는 메서드
    public static synchronized MovieDAO getInstance() {
        if (instance == null) {
            instance = new MovieDAO();
        }
        return instance;
    }

    public Movie getMovieById(int movieId) {
        Movie movie = null;
        try  {
            System.out.println(movieId + "영화 아이디가 제대로 들어감?");
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT * FROM movies WHERE movie_id =?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, movieId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                movie = new Movie(
                        resultSet.getInt("movie_id"),
                        resultSet.getString("movie_name"),
                        resultSet.getString("movie_poster_img"),
                        resultSet.getString("movie_thumbnail_img"),
                        resultSet.getString("movie_genre"),
                        resultSet.getDate("movie_release_date"),
                        resultSet.getInt("movie_running_time"),
                        resultSet.getString("movie_plot"));
            }
        } catch (Exception e) {
            System.out.println("영화 상세 정보를 가져오는데 실패했습니다.");
        }
        return movie;
    }

    public MovieReviewInfo getMovieReviewInfoById(int movieId){
        MovieReviewInfo movieReviewInfo = null;
        try  {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT m.movie_id, COUNT(r.review_id) as reviewCount, AVG(r.review_rating) as ratingAverage"
                    + " FROM movies m LEFT JOIN reviews r ON m.movie_id = r.movie_id "
                    + " WHERE m.movie_id =?"
                    + " GROUP BY m.movie_id";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, movieId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                movieReviewInfo = new MovieReviewInfo(
                        resultSet.getInt("ratingAverage"),
                        resultSet.getInt("reviewCount"));
            }
        } catch (Exception e) {
            System.out.println("리뷰와 관련된 영화 정보를 가져오는데 실패했습니다.");
        }
        return movieReviewInfo;
    }
}


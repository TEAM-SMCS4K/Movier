package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Movie;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MovieDao {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");

    // 싱글톤 인스턴스를 저장할 정적 변수
    private static MovieDao instance;

    // private 생성자를 통해 외부에서의 인스턴스 생성을 방지
    private MovieDao() {}

    // 싱글톤 인스턴스를 반환하는 메서드
    public static synchronized MovieDao getInstance() {
        if (instance == null) {
            instance = new MovieDao();
        }
        return instance;
    }

    public Movie getMovieById(int movieId) {
        Movie movie = null;
        try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT m.*, COUNT(r.review_id) as reviewCount, AVG(r.review_rating) as ratingAverage "
                    + "FROM movies m LEFT JOIN reviews r ON m.movie_id = r.movie_id "
                    + "WHERE m.movie_id =? GROUP BY m.movie_id";

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
                        resultSet.getString("movie_plot"),
                        resultSet.getDouble("ratingAverage"),
                        resultSet.getInt("reviewCount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movie;
    }
}


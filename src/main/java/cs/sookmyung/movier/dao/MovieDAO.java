package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Movie;
import cs.sookmyung.movier.model.MovieReviewInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;

public class MovieDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");
    private static MovieDAO instance;

    private static final Logger LOGGER = LoggerFactory.getLogger(MovieDAO.class);

    private MovieDAO() {}

    public static synchronized MovieDAO getInstance() {
        if (instance == null) {
            instance = new MovieDAO();
        }
        return instance;
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    public Movie getMovieById(int movieId) {
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, movieId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Movie(
                            resultSet.getInt("movie_id"),
                            resultSet.getString("movie_name"),
                            resultSet.getString("movie_poster_img"),
                            resultSet.getString("movie_thumbnail_img"),
                            resultSet.getString("movie_genre"),
                            resultSet.getDate("movie_release_date"),
                            resultSet.getInt("movie_running_time"),
                            resultSet.getString("movie_plot")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("영화 상세 정보를 가져오는데 실패했습니다.", e);
        }
        return null;
    }

    public MovieReviewInfo getMovieReviewInfoById(int movieId) {
        String sql = "SELECT m.movie_id, COUNT(r.review_id) AS reviewCount, AVG(r.review_rating) AS ratingAverage"
                + " FROM movies m LEFT JOIN reviews r ON m.movie_id = r.movie_id"
                + " WHERE m.movie_id = ?"
                + " GROUP BY m.movie_id";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, movieId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new MovieReviewInfo(
                            resultSet.getDouble("ratingAverage"),
                            resultSet.getInt("reviewCount")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("리뷰와 관련된 영화 정보를 가져오는데 실패했습니다.", e);
        }
        return null;
    }

    public Movie getMovieInfoByMovieId(int movieId) throws SQLException {
        Movie movie = null;
        String sql = "{ call get_movie_info_by_movie_id(?, ?) }";
        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(sql)) {
            cstmt.setInt(1, movieId);
            cstmt.registerOutParameter(2, Types.REF_CURSOR);
            cstmt.execute();

            try (ResultSet rs = (ResultSet) cstmt.getObject(2)) {
                if (rs.next()) {
                    movie = new Movie(
                            rs.getInt("movie_id"),
                            rs.getString("movie_name"),
                            rs.getString("movie_poster_img"),
                            rs.getString("movie_genre"),
                            rs.getDate("movie_release_date"),
                            rs.getInt("movie_running_time")
                    );
                }
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException(e);
        }
        return movie;
    }
}

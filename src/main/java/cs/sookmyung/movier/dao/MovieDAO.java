package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Movie;
import cs.sookmyung.movier.model.MovieReviewInfo;
import cs.sookmyung.movier.model.MovieList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");
    private static MovieDAO instance;

    private static final Logger LOGGER = LoggerFactory.getLogger(MovieDAO.class);

    private MovieDAO() {
    }

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

    public List<MovieList> getMovieList() {
        List<MovieList> movieList = new ArrayList<>();
        String sql = "{call get_movie_list_cursor(?)}";

        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {

            callableStatement.registerOutParameter(1, Types.REF_CURSOR);
            callableStatement.execute();

            try (ResultSet resultSet = (ResultSet) callableStatement.getObject(1)) {
                while (resultSet.next()) {
                    MovieList movie = new MovieList(
                            resultSet.getInt("id"),
                            resultSet.getString("title"),
                            resultSet.getString("posterImg"),
                            resultSet.getDouble("rating")
                    );
                    movieList.add(movie);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("영화 목록을 가져오는데 실패했습니다.", e);
        }
        return movieList;
    }

    public List<MovieList> getSearchMovies(String keyword) {
        List<MovieList> movieList = new ArrayList<>();
        String sql = "{call get_search_movie_list_cursor(?, ?)}";

        try (Connection connection = getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {

            callableStatement.setString(1, keyword);  // 첫 번째 매개변수 설정
            callableStatement.registerOutParameter(2, Types.REF_CURSOR);  // 두 번째 매개변수 설정
            callableStatement.execute();

            try (ResultSet resultSet = (ResultSet) callableStatement.getObject(2)) {
                while (resultSet.next()) {
                    MovieList movie = new MovieList(
                            resultSet.getInt("id"),
                            resultSet.getString("title"),
                            resultSet.getString("posterImg"),
                            resultSet.getDouble("rating")
                    );
                    movieList.add(movie);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("영화 목록을 가져오는데 실패했습니다.", e);
        }
        return movieList;
    }

}
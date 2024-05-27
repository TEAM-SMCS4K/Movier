package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.model.MovieReview;
import cs.sookmyung.movier.model.Review;
import cs.sookmyung.movier.config.ConfigLoader;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReviewDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");
    private static ReviewDAO instance;

    private static final Logger LOGGER = LoggerFactory.getLogger(ReviewDAO.class);

    private ReviewDAO() {
    }

    public static synchronized ReviewDAO getInstance() {
        if (instance == null) {
            instance = new ReviewDAO();
        }
        return instance;
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

//    public List<Review> getReviewsByMemberId(int memberId) throws SQLException {
//        List<Review> reviews = new ArrayList<>();
//        String sql = "{ call get_reviews_by_member_id(?, ?) }";
//        try (Connection connection = getConnection();
//             CallableStatement cstmt = connection.prepareCall(sql)) {
//            cstmt.setInt(1, memberId);
//            cstmt.registerOutParameter(2, Types.REF_CURSOR);
//            cstmt.execute();
//
//            ResultSet rs = (ResultSet) cstmt.getObject(2);
//            while (rs.next()) {
//                Review review = new Review(
//                        rs.getInt("review_id"),
//                        rs.getString("movie_poster_img"),
//                        rs.getString("movie_name"),
//                        rs.getDouble("review_rating"),
//                        rs.getString("review_content"),
//                        rs.getDate("review_created_at")
//                );
//                reviews.add(review);
//            }
//        } catch (ClassNotFoundException e) {
//            LOGGER.error("Database driver not found", e);
//            throw new SQLException(e);
//        }
//        return reviews;
//    }

    public List<MovieReview> getReviewsByMovieIdSortedByRating(int movieId, double minRating) throws SQLException {
        List<MovieReview> reviews = new ArrayList<>();
        SympathyDAO sympathyDAO = SympathyDAO.getInstance();
        MemberDAO memberDAO = MemberDAO.getInstance();

        String plsql =
                "DECLARE " +
                        "    review_cursor SYS_REFCURSOR; " +
                        "BEGIN " +
                        "    OPEN review_cursor FOR " +
                        "        SELECT reviewer_id, review_id, review_text, rating, movie_id, review_created_at " +
                        "        FROM reviews " +
                        "        WHERE movie_id = ? AND rating >= ? " +
                        "        ORDER BY rating DESC; " +
                        "    ? := review_cursor; " +
                        "END;";

        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(plsql)) {

            cstmt.setInt(1, movieId);
            cstmt.setDouble(2, minRating);
            cstmt.registerOutParameter(3, Types.REF_CURSOR);
            cstmt.execute();

            try (ResultSet rs = (ResultSet) cstmt.getObject(3)) {
                while (rs.next()) {
                    int review_id = rs.getInt("review_id");
                    int sympathy_count = sympathyDAO.getSympathyCount(review_id);

                    int reviewer_id = rs.getInt("reviewer_id");
                    String reviewer_name = memberDAO.getMemberNameById(reviewer_id);

                    MovieReview review = new MovieReview(
                            review_id,
                            reviewer_id,
                            rs.getInt("movie_id"),
                            rs.getDouble("rating"),
                            rs.getString("review_text"),
                            rs.getDate("review_created_at"),
                            reviewer_name,
                            sympathy_count
                    );
                    reviews.add(review);
                }
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException(e);
        }
        return reviews;
    }

    public List<MovieReview> getReviewsByMovieIdSortedByCreatedAt(int movieId, double minRating) throws SQLException {
        List<MovieReview> reviews = new ArrayList<>();
        SympathyDAO sympathyDAO = SympathyDAO.getInstance();
        MemberDAO memberDAO = MemberDAO.getInstance();

        String plsql =
                "DECLARE " +
                        "    review_cursor SYS_REFCURSOR; " +
                        "BEGIN " +
                        "    OPEN review_cursor FOR " +
                        "        SELECT reviewer_id, review_id, review_text, rating, movie_id, review_created_at " +
                        "        FROM reviews " +
                        "        WHERE movie_id = ? AND rating >= ? " +
                        "        ORDER BY review_created_at DESC; " +
                        "    ? := review_cursor; " +
                        "END;";

        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(plsql)) {

            cstmt.setInt(1, movieId);
            cstmt.setDouble(2, minRating);
            cstmt.registerOutParameter(3, Types.REF_CURSOR);
            cstmt.execute();

            try (ResultSet rs = (ResultSet) cstmt.getObject(3)) {
                while (rs.next()) {
                    int review_id = rs.getInt("review_id");
                    int sympathy_count = sympathyDAO.getSympathyCount(review_id);

                    int reviewer_id = rs.getInt("reviewer_id");
                    String reviewer_name = memberDAO.getMemberNameById(reviewer_id);

                    MovieReview review = new MovieReview(
                            review_id,
                            reviewer_id,
                            rs.getInt("movie_id"),
                            rs.getDouble("rating"),
                            rs.getString("review_text"),
                            rs.getDate("review_created_at"),
                            reviewer_name,
                            sympathy_count
                    );
                    reviews.add(review);
                }
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException(e);
        }
        return reviews;
    }
}

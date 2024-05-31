package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.model.MovieReview;
import cs.sookmyung.movier.model.MyPageReview;
import cs.sookmyung.movier.model.ReviewDetail;
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

    public Review getReviewById(int reviewId) {
        String sql = "SELECT * FROM reviews WHERE review_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, reviewId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new Review(
                            resultSet.getInt("review_id"),
                            resultSet.getInt("reviewer_id"),
                            resultSet.getInt("movie_id"),
                            resultSet.getDouble("review_rating"),
                            resultSet.getString("review_content"),
                            resultSet.getDate("review_created_at")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("리뷰 정보를 가져오는데 실패했습니다.", e);
        }
        return null;
    }

    public int getReviewCountByMemberId(int memberId) throws SQLException {
        int reviewCount = 0;
        String sql = "{ call get_review_count_by_reviewer_id(?, ?) }";
        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(sql)) {
            cstmt.setInt(1, memberId);
            cstmt.registerOutParameter(2, Types.INTEGER);
            cstmt.execute();
            reviewCount = cstmt.getInt(2);
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException(e);
        }
        return reviewCount;
    }

    public List<MyPageReview> getMyPageReviewsByMemberId(int memberId) throws SQLException {
        List<MyPageReview> reviews = new ArrayList<>();
        String sql = "{ call get_reviews_by_reviewer_id(?, ?) }";
        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(sql)) {
            cstmt.setInt(1, memberId);
            cstmt.registerOutParameter(2, Types.REF_CURSOR);
            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            while (rs.next()) {
                MyPageReview review = new MyPageReview(
                        rs.getInt("review_id"),
                        rs.getInt("reviewer_id"),
                        rs.getInt("movie_id"),
                        rs.getDouble("review_rating"),
                        rs.getString("review_content"),
                        rs.getDate("review_created_at"),
                        rs.getString("movie_poster_img"),
                        rs.getString("movie_name")
                );
                reviews.add(review);
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException(e);
        }
        return reviews;
    }

    public ReviewDetail getReviewDetailsByMemberId(int reviewId, int memberId) throws SQLException {
        ReviewDetail reviewDetail = null;
        String sql = "{ call get_review_details_by_reviewer_id(?, ?, ?) }";
        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(sql)) {
            cstmt.setInt(1, reviewId);
            cstmt.setInt(2, memberId);
            cstmt.registerOutParameter(3, Types.REF_CURSOR);
            cstmt.execute();

            try (ResultSet rs = (ResultSet) cstmt.getObject(3)) {
                if (rs.next()) {
                    reviewDetail = new ReviewDetail(
                            rs.getInt("review_id"),
                            rs.getInt("movie_id"),
                            rs.getDouble("review_rating"),
                            rs.getString("review_content"),
                            rs.getString("movie_thumbnail_img")
                    );
                }
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException(e);
        }
        return reviewDetail;
    }


    public boolean deleteReviewById(int reviewId, int memberId) {
        String sql = "DELETE FROM reviews WHERE review_id = ? AND reviewer_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, reviewId);
            pstmt.setInt(2, memberId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("Failed to delete review", e);
            return false;
        }
    }

    public List<MovieReview> getSortedReviewsByMovieId(int movieId, double minRating, String option) {
        List<MovieReview> reviews = new ArrayList<>();
        SympathyDAO sympathyDAO = SympathyDAO.getInstance();
        MemberDAO memberDAO = MemberDAO.getInstance();
        String cs;

        if (option.equals("rating")) {
            cs = getSortedByRatingPLSQL();
        } else {
            cs = getSortedByLatestPLSQL();
        }

        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(cs)) {

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
                            rs.getDouble("review_rating"),
                            rs.getString("review_content"),
                            rs.getDate("review_created_at"),
                            reviewer_name,
                            sympathy_count
                    );
                    reviews.add(review);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            LOGGER.error("Database driver not found", e);
        }
        return reviews;
    }

    private String getSortedByLatestPLSQL() {
        return "{ call get_latest_reviews_by_movie_id(?, ?, ?) }";
    }

    private String getSortedByRatingPLSQL() {
        return "{ call get_rating_reviews_by_movie_id(?, ?, ?) }";
    }

    public int insertReview(Review review) throws SQLException {
        String sql = "{ call insert_review(?, ?, ?, ?, ?, ?) }";

        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.setInt(1, review.getMemberId());
            cstmt.setInt(2, review.getMovieId());
            cstmt.setDouble(3, review.getReviewRating());
            cstmt.setString(4, review.getReviewContent());
            cstmt.setDate(5, new java.sql.Date(review.getReviewCreatedAt().getTime()));
            cstmt.registerOutParameter(6, Types.INTEGER);
            cstmt.execute();
            return cstmt.getInt(6);
        } catch (SQLException e) {
            int errorCode = e.getErrorCode();
            if(errorCode == 20001) {
                LOGGER.error("별점이 입력되지 않았습니다.");
                throw new SQLException("별점이 입력되지 않았습니다.");
            }
            else if(errorCode==20003){
                LOGGER.error("리뷰 내용이 입력되지 않았습니다.");
                throw new SQLException("리뷰 내용이 입력되지 않았습니다.");
            }
            else {
                throw new SQLException("Database error", e);
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException("Database driver not found", e);
        }
    }
    public boolean updateReview(Review review) throws SQLException {
        String sql = "{ call update_review(?, ?, ?, ?, ?, ?) }";

        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.setInt(1, review.getReviewId());
            cstmt.setInt(2, review.getMemberId());
            cstmt.setInt(3, review.getMovieId());
            cstmt.setDouble(4, review.getReviewRating());
            cstmt.setString(5, review.getReviewContent());
            cstmt.setDate(6, new java.sql.Date(review.getReviewCreatedAt().getTime()));
            cstmt.executeUpdate();
            return true;    // 별점이나 리뷰 내용에 변화가 없더라도 수정이라고 간주
        } catch (SQLException e) {
            int errorCode = e.getErrorCode();
            if(errorCode == 20001) {
                LOGGER.error("별점이 입력되지 않았습니다.");
                throw new SQLException("별점이 입력되지 않았습니다.");
            }
            else if(errorCode==20003){
                LOGGER.error("리뷰 내용이 입력되지 않았습니다.");
                throw new SQLException("리뷰 내용이 입력되지 않았습니다.");
            }
            else {
                throw new SQLException("Database error", e);
            }
        } catch (ClassNotFoundException e) {
            LOGGER.error("Database driver not found", e);
            throw new SQLException("Database driver not found", e);
        }
    }
}
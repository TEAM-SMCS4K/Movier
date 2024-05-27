package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.model.MyPageReview;
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

    private ReviewDAO() {}

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

    public int getReviewCountByMemberId(int memberId) throws SQLException {
        int reviewCount = 0;
        String sql = "{ call get_review_count_by_member_id(?, ?) }";
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
        String sql = "{ call get_reviews_by_member_id(?, ?) }";
        try (Connection connection = getConnection();
             CallableStatement cstmt = connection.prepareCall(sql)) {
            cstmt.setInt(1, memberId);
            cstmt.registerOutParameter(2, Types.REF_CURSOR);
            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(2);
            while (rs.next()) {
                MyPageReview review = new MyPageReview(
                        rs.getInt("review_id"),
                        rs.getInt("member_id"),
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
}
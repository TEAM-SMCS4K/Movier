package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;

public class SympathyDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");
    private static SympathyDAO instance;

    private static final Logger LOGGER = LoggerFactory.getLogger(MovieDAO.class);

    private SympathyDAO() {}

    public static synchronized SympathyDAO getInstance() {
        if (instance == null) {
            instance = new SympathyDAO();
        }
        return instance;
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    public int getSympathyCount(int reviewId) {
        // sympathy_count: 리뷰별 공감수를 리턴하는 뷰
        String sql = "SELECT sympathy_count FROM sympathy_count_view WHERE p_review_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, reviewId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("공감 수를 가져오는데 실패했습니다.", e);
        }
        return 0;
    }

    public boolean isSympathyExist(int memberId, int reviewId) {
        String sql = "{ call check_sympathy(?, ?, ?) }";
        boolean result = false;
        try (Connection connection = getConnection(); CallableStatement cstmt = connection.prepareCall(sql)) {
            cstmt.setInt(1, memberId);
            cstmt.setInt(2, reviewId);
            cstmt.registerOutParameter(3, Types.INTEGER);

            cstmt.execute();

            int sympathyResult = cstmt.getInt(3);
            result = (sympathyResult == 1);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("Failed to check sympathy existence.", e);
        }
        return result;
    }

    public boolean addSympathy(int memberId, int reviewId) {
        String sql = "INSERT INTO sympathy (p_member_id, p_review_id) VALUES (?, ?)";
        boolean result = false;
        try (Connection connection = getConnection(); PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, memberId);
            pstmt.setInt(2, reviewId);
            pstmt.executeUpdate();
            result = true;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("Failed to add sympathy.", e);
        }
        return result;
    }

    public boolean removeSympathy(int memberId, int reviewId) {
        String sql = "DELETE FROM sympathy WHERE p_member_id = ? AND p_review_id = ?";
        boolean result = false;
        try (Connection connection = getConnection(); PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, memberId);
            pstmt.setInt(2, reviewId);
            pstmt.executeUpdate();
            result = true;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.error("Failed to remove sympathy.", e);
        }
        return result;
    }
}

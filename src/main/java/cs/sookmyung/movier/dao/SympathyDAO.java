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
}

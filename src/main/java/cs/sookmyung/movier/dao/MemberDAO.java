package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Member;

import java.sql.*;

import java.util.NoSuchElementException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MemberDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");
    private static MemberDAO instance;

    private static final Logger LOGGER = Logger.getLogger(MemberDAO.class.getName());

    private MemberDAO() {}

    public static synchronized MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    public int getMemberIdBySocialPlatformId(String socialPlatformId) {
        String sql = "{? = call get_member_id_by_kakao_platform_id(?)}";
        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.registerOutParameter(1, Types.NUMERIC);
            cstmt.setString(2, socialPlatformId);
            cstmt.execute();
            return cstmt.getInt(1);
        } catch (SQLException e) {
            int errorCode = e.getErrorCode();

            if (errorCode == 20001) {
                LOGGER.log(Level.WARNING, "Member not found for social platform ID: " + socialPlatformId);
                throw new NoSuchElementException("Member not found for social platform ID: " + socialPlatformId);
            } else if (errorCode == 20002) {
                LOGGER.log(Level.SEVERE, "Unexpected error occurred while fetching member ID for social platform ID: " + socialPlatformId);
                throw new RuntimeException("Unexpected error occurred while fetching member ID for social platform ID: " + socialPlatformId);
            } else {
                LOGGER.log(Level.SEVERE, "Failed to fetch member ID by social platform ID. ErrorCode: " + errorCode);
                throw new RuntimeException("Failed to fetch member ID by social platform ID.");
            }
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Failed to fetch member ID by social platform ID. Class not found.");
            throw new RuntimeException("Failed to fetch member ID by social platform ID.");
        }
    }



    public int insertMember(Member member) {
        String sql = "{call insert_member(?, ?, ?, ?)}";
        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.setString(1, member.getNickname());
            cstmt.setString(2, member.getSocialPlatformId());
            cstmt.setString(3, member.getProfileImg());
            cstmt.registerOutParameter(4, Types.NUMERIC);

            cstmt.execute();
            return cstmt.getInt(4);
        } catch (SQLException e) {
            int errorCode = e.getErrorCode();

            if (errorCode == 20002) {
                LOGGER.log(Level.WARNING, "Invalid member_name: " + member.getNickname(), e);
                throw new IllegalArgumentException("Invalid member_name: " + member.getNickname());
            } else if (errorCode == 20003) {
                LOGGER.log(Level.WARNING, "Invalid kakao_platform_id: " + member.getSocialPlatformId(), e);
                throw new IllegalArgumentException("Invalid kakao_platform_id: " + member.getSocialPlatformId());
            } else if (errorCode == 20001) {
                LOGGER.log(Level.SEVERE, "Error inserting member.", e);
                throw new RuntimeException("Error inserting member.", e);
            } else {
                LOGGER.log(Level.SEVERE, "Unexpected error during member insertion. SQLState: " + e.getSQLState() + ", ErrorCode: " + errorCode, e);
                throw new RuntimeException("Error inserting member.", e);
            }
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Failed to insert member. Class not found.", e);
            throw new RuntimeException("Failed to insert member.", e);
        }
    }



    public Member getMemberById(int memberId) {
        String sql = "SELECT * FROM members WHERE member_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, memberId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Member(
                        rs.getString("member_name"),
                        rs.getString("kakao_platform_id"),
                        rs.getString("member_profile_img")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "회원 정보를 가져오는 중에 오류가 발생했습니다.", e);
        }
        return null;
    }

    public String getMemberNameById(int memberId) {
        String sql = "SELECT member_name FROM members WHERE member_id = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, memberId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("member_name");
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "회원 정보를 가져오는 중에 오류가 발생했습니다.", e);
        }
        return null;
    }
}

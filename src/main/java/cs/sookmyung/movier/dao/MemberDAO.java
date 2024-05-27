package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Member;

import java.sql.*;

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
            cstmt.registerOutParameter(1, Types.DECIMAL);
            cstmt.setString(2, socialPlatformId);
            cstmt.execute();
            return cstmt.getInt(1);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "소셜 플랫폼 ID로 회원 ID를 가져오는데 실패했습니다.", e);
            return -1;
        }
    }

    public int insertMember(Member member) {
        String sql = "{call insert_member(?, ?, ?, ?)}";
        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.setString(1, member.getNickname());
            cstmt.setString(2, member.getSocialPlatformId());
            cstmt.setString(3, member.getProfileImg());
            cstmt.registerOutParameter(4, Types.DECIMAL);
            cstmt.execute();
            return cstmt.getInt(4);
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "회원 추가 중에 오류가 발생했습니다.", e);
            return -1;
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

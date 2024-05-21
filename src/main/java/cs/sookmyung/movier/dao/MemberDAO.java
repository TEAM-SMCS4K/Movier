package cs.sookmyung.movier.dao;

import cs.sookmyung.movier.config.ConfigLoader;
import cs.sookmyung.movier.model.Member;

import java.sql.*;

public class MemberDAO {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");
    private static MemberDAO instance;

    private MemberDAO() {}

    public static MemberDAO getInstance() {
        if (instance == null) {
            synchronized (MemberDAO.class) {
                if (instance == null) {
                    instance = new MemberDAO();
                }
            }
        }
        return instance;
    }

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    public int getMemberIdBySocialPlatformId(String socialPlatformId) throws SQLException, ClassNotFoundException {
        String sql = "{? = call get_member_id_by_kakao_platform_id(?)}";
        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.registerOutParameter(1, Types.DECIMAL);
            cstmt.setString(2, socialPlatformId);
            cstmt.execute();
            return cstmt.getInt(1);
        }
    }

    public int insertMember(Member member) throws SQLException, ClassNotFoundException {
        String sql = "{call insert_member(?, ?, ?, ?)}";
        try (Connection conn = getConnection(); CallableStatement cstmt = conn.prepareCall(sql)) {
            cstmt.setString(1, member.getNickname());
            cstmt.setString(2, member.getSocialPlatformId());
            cstmt.setString(3, member.getProfileImg());
            cstmt.registerOutParameter(4, Types.DECIMAL);
            cstmt.execute();
            return cstmt.getInt(4);
        }
    }
}
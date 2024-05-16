package cs.sookmyung.movier;

import cs.sookmyung.movier.config.ConfigLoader;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "SocialLoginServlet", urlPatterns = "/social-login")
public class SocialLoginServlet extends HttpServlet {
    private static final String JDBC_URL = ConfigLoader.getInstance().getKey("oracle.db.url");
    private static final String DB_USER = ConfigLoader.getInstance().getKey("oracle.db.username");
    private static final String DB_PASSWORD = ConfigLoader.getInstance().getKey("oracle.db.password");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String socialPlatformId = request.getParameter("social_platform_id");
        String nickname = request.getParameter("nickname");
        String profileImg = request.getParameter("profile_img");

        Connection conn = null;
        CallableStatement cstmt = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            String getMemberIdSql = "{? = call get_member_id_by_kakao_platform_id(?)}";
            cstmt = conn.prepareCall(getMemberIdSql);
            cstmt.registerOutParameter(1, Types.DECIMAL);
            cstmt.setString(2, socialPlatformId);
            cstmt.execute();

            int userId = cstmt.getInt(1);
            cstmt.close();

            if (userId != 0) {
                HttpSession session = request.getSession();
                session.setAttribute("member_id", userId);
            } else {
                String insertMemberSql = "{call insert_member(?, ?, ?, ?)}";
                cstmt = conn.prepareCall(insertMemberSql);
                cstmt.setString(1, nickname);
                cstmt.setString(2, socialPlatformId);
                cstmt.setString(3, profileImg);
                cstmt.registerOutParameter(4, java.sql.Types.DECIMAL);
                cstmt.execute();

                int memberId = cstmt.getInt(4); // getInt를 사용하여 반환 값 가져오기
                if (memberId != 0) {
                    HttpSession session = request.getSession();
                    session.setAttribute("member_id", memberId);
                } else {
                    response.sendError(500, "회원 가입에 실패했습니다");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // 예외 스택 트레이스 출력
            response.sendError(500, "데이터베이스 오류가 발생했습니다");
        } catch (ClassNotFoundException e) {
            response.sendError(500, "데이터베이스 드라이버를 찾을 수 없습니다");
        } finally {
            try {
                if (cstmt != null) {
                    cstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                response.sendError(500, "데이터베이스 오류가 발생했습니다");
            }
        }
    }
}

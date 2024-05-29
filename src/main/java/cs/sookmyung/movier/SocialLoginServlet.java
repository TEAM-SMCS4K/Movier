package cs.sookmyung.movier;

import cs.sookmyung.movier.dao.MemberDAO;
import cs.sookmyung.movier.model.Member;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.NoSuchElementException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "SocialLoginServlet", urlPatterns = "/social-login")
public class SocialLoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(SocialLoginServlet.class.getName());
    private MemberDAO memberDAO = MemberDAO.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String socialPlatformId = request.getParameter("social_platform_id");
        String nickname = request.getParameter("nickname");
        String profileImg = request.getParameter("profile_img");

        try {
            int userId = memberDAO.getMemberIdBySocialPlatformId(socialPlatformId);

            HttpSession session = request.getSession();
            session.setAttribute("member_id", userId);
        } catch (NoSuchElementException e) {
            // 회원이 존재하지 않으면 새로 생성
            try {
                Member newMember = new Member(nickname, socialPlatformId, profileImg);
                int memberId = memberDAO.insertMember(newMember);

                HttpSession session = request.getSession();
                session.setAttribute("member_id", memberId);
            } catch (IllegalArgumentException ex) {
                LOGGER.log(Level.WARNING, "Invalid input for social platform ID: " + socialPlatformId, ex);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 입력값입니다.");
            } catch (RuntimeException ex) {
                LOGGER.log(Level.SEVERE, "Unexpected error occurred while inserting member for social platform ID: " + socialPlatformId, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "회원 가입에 실패했습니다.");
            }
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Invalid input for social platform ID: " + socialPlatformId, e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 입력값입니다.");
        } catch (RuntimeException e) {
            LOGGER.log(Level.SEVERE, "Unexpected error occurred while fetching member ID for social platform ID: " + socialPlatformId, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "서버 오류가 발생했습니다.");
        }
    }
}
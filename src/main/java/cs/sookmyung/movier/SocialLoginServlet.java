package cs.sookmyung.movier;

import cs.sookmyung.movier.dao.MemberDAO;
import cs.sookmyung.movier.model.Member;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "SocialLoginServlet", urlPatterns = "/social-login")
public class SocialLoginServlet extends HttpServlet {
    private MemberDAO memberDAO = MemberDAO.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String socialPlatformId = request.getParameter("social_platform_id");
        String nickname = request.getParameter("nickname");
        String profileImg = request.getParameter("profile_img");

        int userId = memberDAO.getMemberIdBySocialPlatformId(socialPlatformId);

        if (userId != -1) {
            HttpSession session = request.getSession();
            session.setAttribute("member_id", userId);
        } else {
            Member newMember = new Member(nickname, socialPlatformId, profileImg);
            int memberId = memberDAO.insertMember(newMember);

            if (memberId != -1) {
                HttpSession session = request.getSession();
                session.setAttribute("member_id", memberId);
            } else {
                response.sendError(500, "회원 가입에 실패했습니다");
            }
        }
    }
}
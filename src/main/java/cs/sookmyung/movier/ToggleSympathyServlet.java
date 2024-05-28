package cs.sookmyung.movier;

import cs.sookmyung.movier.dao.SympathyDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name="/toggleSympathy", urlPatterns = "/toggle-sympathy")
public class ToggleSympathyServlet extends HttpServlet {
    private static final Logger LOGGER = LoggerFactory.getLogger(ToggleSympathyServlet.class);
    private static final SympathyDAO sympathyDAO = SympathyDAO.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        int memberId = Integer.parseInt(request.getParameter("memberId"));
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));

        boolean isSympathized = sympathyDAO.isSympathyExist(memberId, reviewId);
        boolean success = isSympathized ? sympathyDAO.removeSympathy(memberId, reviewId)
                : sympathyDAO.addSympathy(memberId, reviewId);

        int totalLikes = success ? sympathyDAO.getSympathyCount(reviewId) : 0;

        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            out.printf("{\"success\":%b, \"isSympathized\":%b, \"totalLikes\":%d}", success, !isSympathized, totalLikes);
        } catch (IOException e) {
            LOGGER.error("공감 토글에 실패했습니다.", e);
        }
    }
}

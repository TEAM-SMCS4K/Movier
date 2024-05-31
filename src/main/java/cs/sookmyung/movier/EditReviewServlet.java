package cs.sookmyung.movier;

import cs.sookmyung.movier.dao.ReviewDAO;
import cs.sookmyung.movier.model.Review;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet(name = "EditReviewServlet", urlPatterns = "/edit-review")
public class EditReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = ReviewDAO.getInstance();

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String body = sb.toString();

        try {
            JSONObject json = new JSONObject(body);
            int reviewId = json.getInt("reviewId");
            int memberId = json.getInt("memberId");
            int movieId = json.getInt("movieId");
            double reviewRating = json.getDouble("starRating");
            String reviewContent = json.getString("reviewContent");
            Date reviewCreatedAt = Date.valueOf(LocalDate.now());

            Review newReview = new Review(reviewId, memberId, movieId, reviewRating, reviewContent, reviewCreatedAt);
            boolean updated = reviewDAO.updateReview(newReview);

            if (updated) {
                HttpSession session = request.getSession();
                session.setAttribute("review_id", reviewId);
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"message\":\"리뷰가 성공적으로 수정되었습니다.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\":\"리뷰 수정에 실패했습니다.\"}");
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\":\"SQL 오류가 발생했습니다: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"message\":\"서버 오류가 발생했습니다: " + e.getMessage() + "\"}");
        }
    }
}

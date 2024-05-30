package cs.sookmyung.movier;

import cs.sookmyung.movier.dao.ReviewDAO;
import cs.sookmyung.movier.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet(name = "writeReviewServlet", urlPatterns = "/write-review")
public class WriteReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = ReviewDAO.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        int memberId = Integer.parseInt(request.getParameter("memberId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        double reviewRating = Double.parseDouble(request.getParameter("starRating"));
        String reviewContent = request.getParameter("reviewContent");
        Date reviewCreatedAt = Date.valueOf(LocalDate.now());

        Review newReview = new Review(memberId, movieId, reviewRating, reviewContent, reviewCreatedAt);
        try {
            int reviewId = reviewDAO.insertReview(newReview);
            HttpSession session = request.getSession();
            session.setAttribute("review_id", reviewId);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"message\":\"리뷰가 성공적으로 등록되었습니다.\"}");
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}

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
import java.time.LocalDate;

@WebServlet(name = "writeReviewServlet", urlPatterns = "/writeReview")
public class WriteReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = ReviewDAO.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int memberId = Integer.parseInt(request.getParameter("memberId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String reviewRatingStr = request.getParameter("starRating");
        String reviewContent = request.getParameter("reviewContent");
        Date reviewCreatedAt = Date.valueOf(LocalDate.now());

        double reviewRating = 0.0;
        if (reviewRatingStr != null && !reviewRatingStr.isEmpty()) {
            try {
                reviewRating = Double.parseDouble(reviewRatingStr);
            } catch (NumberFormatException e) {
                response.getWriter().println("Invalid rating value. Please enter a numeric value.");
                return;
            }
        }

        Review newReview = new Review(movieId, memberId, reviewRating, reviewContent, reviewCreatedAt);
        int reviewId = reviewDAO.insertReview(newReview);

        if (reviewId != -1) {
            HttpSession session = request.getSession();
            session.setAttribute("review_id", reviewId);
            response.sendRedirect("/myReview.jsp");
        } else {
            response.sendError(500, "리뷰 등록에 실패했습니다");
        }
    }
}
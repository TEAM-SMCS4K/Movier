<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Review" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<%@ page import="java.util.List" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    if (memberId == null) {
        response.sendRedirect("socialLogin.jsp");
        return;
    }

    MemberDAO memberDao = MemberDAO.getInstance();
    Member member = memberDao.getMemberById(memberId);
    if (member == null) {
        response.sendRedirect("socialLogin.jsp");
        return;
    }

    ReviewDAO reviewDao = ReviewDAO.getInstance();
    List<Review> reviews = reviewDao.getReviewsByMemberId(memberId);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MOVIER</title>
    <link rel="stylesheet" href="css/myPage.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navTabBar.jsp" />
<div class="my-profile">
    <img src="<%= member.getProfileImg() != null ? member.getProfileImg() : "img/profile.svg" %>" alt="Profile Picture" class="profile-pic">
    <p class="my-profile-nickname"><%= member.getNickname() %></p>
    <p class="message">축하해요! 지금까지 <%= reviews.size() %>개의 리뷰를 작성했네요</p>
</div>
<div class="reviews">
    <h2>내가 작성한 리뷰들</h2>
    <div class="review-list">
        <%
            if (reviews == null || reviews.isEmpty()) {
        %>
        <p>영화를 관람하고 <strong><%= member.getNickname() %></strong>님만의 리뷰를 작성해보세요!</p>
        <%
        } else {
            for (Review review : reviews) {
                String truncatedReviewContent = review.getReviewContent().length() > 80
                        ? review.getReviewContent().substring(0, 80) + "･･･"
                        : review.getReviewContent();
        %>
        <div class="review" onclick="location.href='reviewDetail.jsp?id=<%= review.getReviewId() %>'">
            <img src="<%= review.getPosterImg() != null ? review.getPosterImg() : "img/movie_poster_dummy.svg" %>" alt="Movie Poster" class="review-poster">
            <div class="review-details">
                <div class="title-rating">
                    <h3><%= review.getTitle() %></h3>
                    <span> <img src="img/icn_star_full.svg" alt="Rating Star" class="rating-star"></span>
                    <span class="rating"><%= review.getRating() %> / 5</span>
                </div>
                <p class="review-content"><%= truncatedReviewContent %></p>
                <p class="review-date"><%= review.getFormattedReviewCreatedAt() %> 작성</p>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>
</body>
</html>

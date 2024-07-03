<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.MyPageReview" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<%@ page import="java.util.List" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    boolean redirectToLogin = false;
    String alertMessage = "";
    int reviewCount = 0;

    if (memberId == null) {
        redirectToLogin = true;
        alertMessage = "로그인이 필요합니다";
    } else {
        MemberDAO memberDao = MemberDAO.getInstance();
        Member member = memberDao.getMemberById(memberId);

        if (member == null) {
            redirectToLogin = true;
            alertMessage = "잘못된 접근입니다";
        } else {
            ReviewDAO reviewDao = ReviewDAO.getInstance();
            List<MyPageReview> myPageReviews = reviewDao.getMyPageReviewsByMemberId(memberId);
            reviewCount = reviewDao.getReviewCountByMemberId(memberId);
            request.setAttribute("myPageReviews", myPageReviews);
            request.setAttribute("member", member);
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MOVIER</title>
    <link rel="stylesheet" href="css/myPage.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            <% if (redirectToLogin) { %>
            alert("<%= alertMessage %>");
            window.location.href = 'socialLogin.jsp';
            <% } %>
        });
    </script>
</head>
<body>
<header>
    <jsp:include page="navTabBar.jsp"></jsp:include>
</header>
<div class="main-content">
    <%
        if (!redirectToLogin) {
            Member member = (Member) request.getAttribute("member");
            List<MyPageReview> myPageReviews = (List<MyPageReview>) request.getAttribute("myPageReviews");
    %>
    <div class="my-profile">
        <img src="<%= member.getProfileImg() != null ? member.getProfileImg() : "img/profile.svg" %>" alt="Profile Picture" class="profile-pic">
        <p class="my-profile-nickname"><%= member.getNickname() %></p>
        <p class="message">축하해요! 지금까지 <%= reviewCount %>개의 리뷰를 작성했네요</p>
    </div>
    <div class="reviews">
        <h2>내가 작성한 리뷰들</h2>
        <div class="review-list">
            <%
                if (myPageReviews == null || myPageReviews.isEmpty()) {
            %>
            <p class="write-review">영화를 관람하고 <strong><%= member.getNickname() %></strong>님만의 리뷰를 작성해보세요!</p>
            <%
            } else {
                for (MyPageReview myPageReview : myPageReviews) {
                    String truncatedReviewContent = myPageReview.getReviewContent().length() > 100
                            ? myPageReview.getReviewContent().substring(0, 100) + "…"
                            : myPageReview.getReviewContent();
                    String truncatedTitle = myPageReview.getTitle().length() > 7
                            ? myPageReview.getTitle().substring(0, 7) + "…"
                            : myPageReview.getTitle();
            %>
            <div class="review" onclick="location.href='myReview.jsp?reviewId=<%= myPageReview.getReviewId() %>'">
                <img src="<%= myPageReview.getPosterImg() != null ? myPageReview.getPosterImg() : "img/movie_poster_dummy.svg" %>" alt="Movie Poster" class="review-poster">
                <div class="review-details">
                    <div class="title-rating">
                        <h3><%= truncatedTitle %></h3>
                        <span> <img src="img/icn_star_full.svg" alt="Rating Star" class="rating-star"></span>
                        <span class="rating"><%= myPageReview.getReviewRating() %> / 5</span>
                    </div>
                    <p class="review-content"><%= truncatedReviewContent %></p>
                    <p class="review-date"><%= myPageReview.getFormattedReviewCreatedAt() %> 작성</p>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>

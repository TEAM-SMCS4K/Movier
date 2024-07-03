<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.ReviewDetail" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    boolean redirectToLogin = false;
    boolean redirectToMyPage = false;
    String alertMessage = "";
    ReviewDetail reviewDetail = null;

    if (memberId == null) {
        redirectToLogin = true;
        alertMessage = "로그인이 필요합니다.";
    } else {
        String reviewIdParameter = request.getParameter("reviewId");
        if (reviewIdParameter != null && !reviewIdParameter.isEmpty()) {
            int reviewId = Integer.parseInt(reviewIdParameter);
            ReviewDAO reviewDAO = ReviewDAO.getInstance();
            reviewDetail = reviewDAO.getReviewDetailsByMemberId(reviewId, memberId);

            if (reviewDetail == null) {
                redirectToMyPage = true;
                alertMessage = "리뷰를 찾을 수 없습니다.";
            } else {
                request.setAttribute("reviewDetail", reviewDetail);
            }
        } else {
            redirectToMyPage = true;
            alertMessage = "잘못된 접근입니다.";
        }
    }

    if ("POST".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
        String reviewIdParameter = request.getParameter("reviewId");
        if (reviewIdParameter != null && !reviewIdParameter.isEmpty()) {
            int reviewIdToDelete = Integer.parseInt(reviewIdParameter);
            ReviewDAO reviewDAO = ReviewDAO.getInstance();
            boolean isDeleted = reviewDAO.deleteReviewById(reviewIdToDelete, memberId);
            if (isDeleted) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.sendRedirect("myPage.jsp");
                return;
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
%>
<html>
<head>
    <link rel="stylesheet" href="/css/myReview.css">
    <link rel="stylesheet" href="/css/writeReview.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function confirmDelete(reviewId, memberId) {
            if (confirm("리뷰를 삭제하시겠습니까?")) {
                $.ajax({
                    url: 'myReview.jsp',
                    type: 'POST',
                    data: {
                        action: 'delete',
                        reviewId: reviewId,
                        memberId: memberId
                    },
                    success: function() {
                        alert('리뷰가 삭제되었습니다.');
                        window.location.href = 'myPage.jsp';
                    },
                    error: function(xhr, status, error) {
                        alert('리뷰 삭제에 실패했습니다.');
                        console.error('서버 응답:', xhr.responseText);
                    }
                });
            } else {
                alert('리뷰 삭제를 취소했습니다.');
            }
        }

        $(document).ready(function() {
            <% if (redirectToLogin) { %>
            alert("<%= alertMessage %>");
            window.location.href = 'socialLogin.jsp';
            <% } else if (redirectToMyPage) { %>
            alert("<%= alertMessage %>");
            window.location.href = 'myPage.jsp';
            <% } %>
        });
    </script>
</head>
<body>
<% if (redirectToLogin || redirectToMyPage) { %>
<script>
    alert("<%= alertMessage %>");
    window.location.href = '<%= redirectToLogin ? "socialLogin.jsp" : "myPage.jsp" %>';
</script>
<% } else if (reviewDetail != null) { %>
<div class="background-container" style="background: url('<%= reviewDetail.getThumbnailImg() %>') no-repeat center / cover;">
    <jsp:include page="/navTabBar.jsp"/>
    <div class="review-card">
        <jsp:include page="/detailsComponent.jsp">
            <jsp:param name="movieId" value="<%= reviewDetail.getMovieId() %>"/>
        </jsp:include>
        <div class="review-content">
            <h2>나의 별점</h2>
            <div class="rating-container">
                <div class="rating-number" id="rating-number"><%= reviewDetail.getReviewRating() %></div>
                <div class="star-container">
                    <%
                        double rating = reviewDetail.getReviewRating();
                        int fullStars = (int) rating;
                        boolean halfStar = (rating - fullStars) >= 0.5;
                        for (int i = 1; i <= fullStars; i++) {
                    %>
                    <img src="<%= request.getContextPath() %>/img/icn_star_full.svg" alt="Full Star">
                    <%
                        }
                        if (halfStar) {
                    %>
                    <div class="half-star-container">
                        <img src="<%= request.getContextPath() %>/img/icn_star_full.svg" class="half-star" alt="Half Star">
                        <img src="<%= request.getContextPath() %>/img/icn_star_empty.svg" class="half-star-bg" alt="Empty Half Star">
                    </div>
                    <%
                        }
                        for (int i = fullStars + (halfStar ? 1 : 0); i < 5; i++) {
                    %>
                    <img src="<%= request.getContextPath() %>/img/icn_star_empty.svg" alt="Empty Star">
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="review-text">
                <p><%= reviewDetail.getReviewContent() %></p>
            </div>
            <div class="review-submit">
                <button class="edit-button" onclick="location.href='editReview.jsp?reviewId=<%= reviewDetail.getReviewId() %>'">수정하기</button>
                <button class="delete-button" onclick="confirmDelete(<%= reviewDetail.getReviewId() %>, <%= memberId %>);">삭제하기</button>
            </div>
        </div>
    </div>
</div>
<% } %>
</body>
</html>
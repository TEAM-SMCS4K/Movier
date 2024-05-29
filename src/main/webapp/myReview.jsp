<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.ReviewDetail" %>

<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    boolean redirectToLogin = false;
    String alertMessage = "";
    ReviewDetail reviewDetail = null;

    if (memberId == null) {
        redirectToLogin = true;
        alertMessage = "로그인이 필요합니다.";
    } else {
        String idParameter = request.getParameter("id");
        if (idParameter != null && !idParameter.isEmpty()) {
            int reviewId = Integer.parseInt(idParameter);
            ReviewDAO reviewDAO = ReviewDAO.getInstance();
            reviewDetail = reviewDAO.getReviewDetailsByMemberId(reviewId, memberId);

            if (reviewDetail == null) {
                redirectToLogin = true;
                alertMessage = "리뷰를 찾을 수 없습니다.";
            } else {
                request.setAttribute("reviewDetail", reviewDetail);
            }
        } else {
            redirectToLogin = true;
            alertMessage = "리뷰 ID가 제공되지 않았습니다.";
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

    <script>
        function confirmDelete(reviewId, memberId) {
            if (confirm("리뷰를 삭제하시겠습니까?")) {
                fetch('myReview.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'action=delete&reviewId=' + reviewId + '&memberId=' + memberId.toString()
                }).then(response => {
                    console.log(response);
                    if (response.ok) {
                        alert('리뷰가 삭제되었습니다.');
                        window.location.href = 'myPage.jsp';
                    } else {
                        response.text().then(text => {
                            console.error('서버 응답:', text);
                            alert('리뷰 삭제를 취소했습니다.');
                        });
                    }
                }).catch(error => {
                    console.error('Fetch Error:', error);
                    alert('리뷰 삭제에 실패했습니다.');
                });
            }
        }
    </script>
</head>
<body>
<% if (redirectToLogin) { %>
<script>
    alert("<%= alertMessage %>");
    window.location.href = 'socialLogin.jsp';
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
            <div class="review-text">
                <p><%= reviewDetail.getReviewContent() %></p>
            </div>
            <div class="review-submit">
                <button class="edit-button" onclick="location.href='editReview.jsp?id=<%= reviewDetail.getReviewId() %>&movieId=<%= reviewDetail.getMovieId() %>'">수정하기</button>
                <button class="delete-button" onclick="confirmDelete(<%= reviewDetail.getReviewId() %>, <%= memberId %>);">삭제하기</button>
            </div>
        </div>
    </div>
</div>
<% } %>
</body>
</html>

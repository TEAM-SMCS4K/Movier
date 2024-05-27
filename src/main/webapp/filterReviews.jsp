<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/27/24
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.MovieReview" %>
<%
    String sortOption = request.getParameter("sortOption");
    double minRating = Double.parseDouble(request.getParameter("minRating"));
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    ReviewDAO reviewDAO = ReviewDAO.getInstance();
    List<MovieReview> reviewList;

    // 필터링 옵션에 따라 리뷰 목록 가져오기
    reviewList = reviewDAO.getSortedReviewsByMovieId(movieId, minRating, sortOption);

    if (reviewList.isEmpty()) {
%>
<head>
    <style>
        .no-reviews{
            font-family: 'SUIT';
            font-style: normal;
            font-weight: 500;
            font-size: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #8B8484;
            margin-top: 200px;
        }
    </style>
</head>
<body>
<div class="no-reviews">
    <p>작성된 리뷰가 없습니다.</p>
</div>
<%
} else {
    for (MovieReview review : reviewList) {
        request.setAttribute("review", review);
        request.setCharacterEncoding("UTF-8");
%>
<jsp:include page="reviewComponent.jsp">
    <jsp:param name="reviewer" value="<%= review.getReviewerName() %>" />
    <jsp:param name="rating" value="<%= review.getReviewRating() %>" />
    <jsp:param name="date" value="<%= review.getFormattedReviewCreatedAt() %>" />
    <jsp:param name="text" value="<%= review.getReviewContent() %>" />
    <jsp:param name="likes" value="<%= review.getSympathyCount() %>" />
</jsp:include>
<%
        }
    }
%>
</body>



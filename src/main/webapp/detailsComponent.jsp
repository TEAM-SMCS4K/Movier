<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%@ page import="java.sql.SQLException" %>

<%
    int reviewId = Integer.parseInt(request.getParameter("id"));
    ReviewDAO reviewDAO = ReviewDAO.getInstance();
    Movie movie = null;

    try {
        movie = reviewDAO.getMovieInfoByReviewId(reviewId);
        if (movie == null) {
            throw new SQLException("No movie found for the given review ID.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    request.setAttribute("movie", movie);
%>

<html>
<head>
    <link rel="stylesheet" href="/css/detailsComponent.css">
</head>
<body>
<% if (movie != null) { %>
<div class="movie-details">
    <img src="<%= movie.getPosterImg() %>" alt="Movie Poster" class="movie-poster">
    <div class="movie-info">
        <div class="movie-title"><%= movie.getTitle() %></div>
        <div class="movie-genre"><%= movie.getGenre() %></div>
        <div class="release-date"><%= movie.getReleaseDateAndRunningTime() %></div>
    </div>
</div>
<% } else { %>
<div class="movie-details">
    <p>영화 정보를 불러올 수 없습니다.</p>
</div>
<% } %>
</body>
</html>

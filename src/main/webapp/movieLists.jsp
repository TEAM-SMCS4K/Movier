<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cs.sookmyung.movier.model.MovieList" %>
<%
    List<MovieList> movieList = (List<MovieList>) request.getAttribute("movieList");
%>
<html>
<head>
    <title>Movie List</title>
    <link rel="stylesheet" href="css/movieLists.css">
</head>
<body>
<span class="movie_list_title">무비차트</span>
<div class="movie_list_grid">
    <% for (MovieList movie : movieList) { %>
    <div class="cell" data-movie-id="<%= movie.getId() %>" style="cursor:pointer;">
        <img src="<%= movie.getPosterImg() %>" alt="poster" class="poster">
        <span class="movie_title"><%= movie.getTitle() %></span>
        <div class="ratingBox">
            <img src="img/icn_star_full.svg" alt="rating" class="rating_icon">
            <span class="movie_rating"><%= movie.getRating() %> (<%= movie.getReview_count() %>)</span>
        </div>
    </div>
    <% } %>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const movieCells = document.querySelectorAll(".cell");

        movieCells.forEach(cell => {
            cell.addEventListener("click", function() {
                const movieId = this.getAttribute("data-movie-id");
                window.location.href = "movieDetail.jsp?movieId=" + movieId;
            });
        });
    });
</script>
</body>
</html>

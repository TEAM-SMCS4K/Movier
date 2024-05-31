<%--
  Created by IntelliJ IDEA.
  User: kwonjeong
  Date: 5/20/24
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>
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
    <div class="cell">
        <img src="<%= movie.getPosterImg() %>" alt="poster" class="poster">
        <span class="movie_title"><%= movie.getTitle() %></span>
        <div class="ratingBox">
            <img src="img/icn_star_full.svg" alt="rating" class="rating_icon">
            <span class="movie_rating"><%= movie.getRating() %> (<%= movie.getReview_count() %>)</span>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>


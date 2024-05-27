<%--
  Created by IntelliJ IDEA.
  User: kwonjeong
  Date: 5/20/24
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.model.MovieList" %>
<%
    MovieList movie = (MovieList) request.getAttribute("movie");
%>
<html>
<head>
    <title>Movie List Cell</title>
    <link rel="stylesheet" href="css/movieListCell.css">
</head>
<body>
<div class="cell">
    <img src="<%= movie.getPosterImg() %>" alt="poster" class="poster">
    <span class="movie_title"><%= movie.getTitle() %></span>
    <div class="ratingBox">
        <img src="img/icn_star_full.svg" alt="rating" class="rating_icon">
        <span class="movie_rating"><%= movie.getRating() %> (리뷰 수)</span>
    </div>
</div>
</body>
</html>


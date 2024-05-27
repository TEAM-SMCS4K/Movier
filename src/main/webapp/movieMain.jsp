<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.MovieList" %>
<%
    MovieDAO movieDAO = MovieDAO.getInstance();
    List<MovieList> movieList = movieDAO.getMovieList();
    request.setAttribute("movieList", movieList);
%>
<html>
<head>
    <title>Main Movie List</title>
    <link rel="stylesheet" href="css/movieMain.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body class="main-page">
<header>
    <jsp:include page="navTabBar.jsp"></jsp:include>
</header>
<div class="main">
    <img src="img/movier_logo.svg" alt="logo" class="logo">
    <div class="searchBox">
        <img src="img/icn_search.svg" alt="search" class="search_icon">
        <input type="text" id="search_input" placeholder="영화의 제목을 입력하세요.">
    </div>
    <div class="movie_list">
        <span class="movie_list_title">무비차트</span>
        <div class="movie_list_grid">
            <%
                for (MovieList movie : movieList) {
                    request.setAttribute("movie", movie);
            %>
            <jsp:include page="movieListCell.jsp"></jsp:include>
            <% } %>
        </div>
    </div>
</div>
<script src="js/movieMain.js"></script>
</body>
</html>
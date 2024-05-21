<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/16/24
  Time: 8:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDao" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%@ page import="cs.sookmyung.movier.model.MovieReviewInfo" %>
<%
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    MovieDao movieDao = MovieDao.getInstance();
    Movie movie = movieDao.getMovieById(movieId);
    MovieReviewInfo movieReviewInfo = movieDao.getMovieReviewInfoById(movieId);

    if(movie == null || movieReviewInfo == null){
        response.sendRedirect("/movieMain.jsp");
        return;
    }

    double startRatingWidth = (movieReviewInfo.getRatingAverage() / 5) * 100;
%>

<html>
<head>
    <title>Movier</title>
    <link rel="stylesheet" href="css/movieDetail.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
<div class="background-container" style="background: url(<%=movie.getThumbnailImg()%>)no-repeat center /cover">
    <jsp:include page="/navTabBar.jsp" />
    <div class="movie-details">
        <img src="<%=movie.getPosterImg()%>"
             alt="Movie Poster" class="movie-poster">
        <div class="movie-info">
            <div class="movie-header">
                <div class="movie-title"><p><%=movie.getTitle()%></p></div>
                <div class="genre"><%=movie.getGenre()%></div>
            </div>
            <div class="release-date"><%=movie.getReleaseDateAndRunningTime()%></div>
            <div class="rating">
                <div class="score"><p><%=movieReviewInfo.getRatingAverage()%></p></div>
                <div class="star-rate">
                    <span style="width: <%=startRatingWidth%>%"></span>
                </div>
                <div class="review-count"><p><%=movieReviewInfo.getReviewCount()%></p></div>
            </div>
        </div>
    </div>
    <div class="main-content">
        <div class="summary">
            <%=movie.getPlot()%>
        </div>
        <jsp:include page="/reviewRequest.jsp" />
        <jsp:include page="/reviewList.jsp"/>
    </div>
</div>
</body>
</html>

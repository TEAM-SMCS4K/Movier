<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/16/24
  Time: 8:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%@ page import="cs.sookmyung.movier.model.MovieReviewInfo" %>

<html>
<head>
    <title>Movier</title>
    <link rel="stylesheet" href="css/movieDetail.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
<%
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    MovieDAO movieDao = MovieDAO.getInstance();
    Movie movie = movieDao.getMovieById(movieId);
    MovieReviewInfo movieReviewInfo = movieDao.getMovieReviewInfoById(movieId);

    if(movie == null || movieReviewInfo == null){
%>
<script type="text/javascript">
    alert("잘못된 접근입니다");
    window.location.href = "/movieMain.jsp";
</script>
<%
        return;
    }

    double startRatingWidth = (movieReviewInfo.getRatingAverage() / 5) * 100;
%>
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
        <jsp:include page="/reviewRequest.jsp">
            <jsp:param name="movieId" value="<%=movieId%>" />
        </jsp:include>
        <jsp:include page="/reviewList.jsp"/>
    </div>
</div>
</body>
</html>

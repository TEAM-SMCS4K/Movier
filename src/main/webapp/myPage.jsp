<%--
  Created by IntelliJ IDEA.
  User: yoonji
  Date: 5/20/24
  Time: 1:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cs.sookmyung.movier.Review" %>
<%
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MOVIER</title>
    <link rel="stylesheet" href="css/myPage.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/navTabBar.jsp" />
<div class="my-profile">
    <img src="img/profile.svg" alt="Profile Picture" class="profile-pic">
    <p class="nickname">갈라파고스의 소시지</p>
    <p class="message">축하해요! 지금까지 N개의 리뷰를 작성했네요</p>
</div>
<div class="reviews">
    <h2>내가 작성한 리뷰들</h2>
    <div class="review-list">
        <div class="review">
            <img src="img/poster.svg" alt="Movie Poster" class="review-poster">
            <div class="review-details">
                <div class="title-rating">
                    <h3>범죄도시 4</h3>
                    <span> <img src="img/16_16_star.svg"></span>
                    <span class="rating">4.8</span>
                    <span class="review-count">(3)</span>
                </div>
                <p class="review-content"> 영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요...</p>
                <p class="review-date">2024. 05. 11 작성</p>
            </div>
        </div>
        <div class="review">
            <img src="img/poster.svg" alt="Movie Poster" class="review-poster">
            <div class="review-details">
                <div class="title-rating">
                    <h3>범죄도시 4</h3>
                    <span> <img src="img/16_16_star.svg"></span>
                    <span class="rating">4.8</span>
                    <span class="review-count">(3)</span>
                </div>
                <p class="review-content">영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요...</p>
                <p class="review-date">2024. 05. 11 작성</p>
            </div>
        </div>
        <div class="review">
            <img src="img/poster.svg" alt="Movie Poster" class="review-poster">
            <div class="review-details">
                <div class="title-rating">
                    <h3>범죄도시 4</h3>
                    <span> <img src="img/16_16_star.svg"></span>
                    <span class="rating">4.8</span>
                    <span class="review-count">(3)</span>
                </div>
                <p class="review-content">영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요...</p>
                <p class="review-date">2024. 05. 11 작성</p>
            </div>
        </div>
        <div class="review">
            <img src="img/poster.svg" alt="Movie Poster" class="review-poster">
            <div class="review-details">
                <div class="title-rating">
                    <h3>범죄도시 4</h3>
                    <span> <img src="img/16_16_star.svg"></span>
                    <span class="rating">4.8</span>
                    <span class="review-count">(3)</span>
                </div>
                <p class="review-content">영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요 영화가 감동적이에요...</p>
                <p class="review-date">2024. 05. 11 작성</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>

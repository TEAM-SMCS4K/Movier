<%--
  Created by IntelliJ IDEA.
  User: nache
  Date: 24. 5. 20.
  Time: 오후 4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movier Review</title>
    <link rel="stylesheet" href="/css/writeReview.css">
</head>
<body>
    <div class="background-container" style="background: url(http://img.cgv.co.kr/Movie/Thumbnail/StillCut/000088/88104/88104224213_727.jpg)no-repeat center /cover">
        <jsp:include page="/navTabBar.jsp"/>
        <div class="review-card">
            <div class="movie-details">
                <img src="https://i.namu.wiki/i/rrHaHzTJSB5C7asmwf7DtFFVhVRB7mHMxo3W2UgFEskNo7zpQI68SL_2M7Bbftl3YoM-6yp-ydelIm7U2pOwHw.webp"
                    alt="Movie Poster" class="movie-poster">
                <div class="movie-info">
                    <div class="movie-title">범죄도시 4</div>
                    <div class="movie-genre">액션/범죄</div>
                    <div class="release-date">2024.04.24 | 109분</div>
                </div>
            </div>
            <div class="review-content">
                <h2>나의 별점</h2>
                <div class="rating">
                    별점 기능 들어갈 자리
                </div>
                <div class="review-input">
                    <input type="text" class="input-box" placeholder="범죄도시 4에 대한 갈라파고스 소시지 님의 생각을 써주세요!">
                </div>
                <div class="review-submit">
                    <input type="submit" class="submit-button" value="등록하기">
                </div>
            </div>
        </div>
    </div>
</body>
</html>

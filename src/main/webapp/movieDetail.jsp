<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/16/24
  Time: 8:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movier</title>
    <link rel="stylesheet" href="css/movieDetail.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
<div class="background-container">
    <jsp:include page="/navTabBar.jsp" />
    <div class="movie-details">
        <img src="https://i.namu.wiki/i/rrHaHzTJSB5C7asmwf7DtFFVhVRB7mHMxo3W2UgFEskNo7zpQI68SL_2M7Bbftl3YoM-6yp-ydelIm7U2pOwHw.webp"
             alt="Movie Poster" class="movie-poster">
        <div class="movie-info">
            <div class="movie-header">
                <div class="movie-title"><p>범죄도시 4</p></div>
                <div class="genre">액션/범죄</div>
            </div>
            <div class="release-date">2024.04.24 | 109분</div>
            <div class="rating">
                <div class="score"><p>4.5</p></div>
                <div class="star-rate">
                    <span style="width: 50%"></span>
                </div>
                <div class="review-count"><p>(100+)</p></div>
            </div>
        </div>
    </div>
    <div class="main-content">
        <div class="summary">
            신종 마약 사건 3년 뒤,<br>
            괴물형사 ‘마석도’(마동석)와 서울 광수대는<br>
            배달앱을 이용한 마약 판매 사건을 수사하던 중<br>
            수배 중인 앱 개발자가 필리핀에서 사망한 사건이<br>
            대규모 온라인 불법 도박 조직과 연관되어 있음을 알아낸다.<br>
            <br>
            필리핀에 거점을 두고 납치, 감금, 폭행, 살인 등으로<br>
            대한민국 온라인 불법 도박 시장을 장악한<br>
            특수부대 용병 출신의 빌런 ‘백창기’(김무열)와<br>
            한국에서 더 큰 판을 짜고 있는 IT업계 천재 CEO ‘장동철’(이동휘).<br>

            ‘마석도’는 더 커진 판을 잡기 위해<br>
            ‘장이수’(박지환)에게 뜻밖의 협력을 제안하고<br>
            광역수사대는 물론,<br>
            사이버수사대까지 합류해 범죄를 소탕하기 시작하는데…<br>
        </div>
        <jsp:include page="/reviewRequest.jsp" />
        <jsp:include page="/reviewList.jsp"/>
    </div>
</div>
</body>
</html>

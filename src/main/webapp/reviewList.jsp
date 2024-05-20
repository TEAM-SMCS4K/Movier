<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/20/24
  Time: 9:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movier</title>
    <link rel="stylesheet" href="css/reviewList.css">
</head>
<body>
<div class="review-list-section">
    <div class="review-list-title"><p>다른 사람의 리뷰</p></div>
    <div class="review-list-option">
        <div class="sort-area">
            <div><p>최신순</p></div>
            <div><p>별점순</p></div>
        </div>
        <div class="separator-area"><p>|</p></div>
        <div class="filter-area">
            <div class="filter-bar">
                <label for="review-slider" class="rating-label">별점 필터</label>
                <img src="img/ic_star_full.svg"/>
                <p>2.5</p>
                <input id="review-slider" type="range" min="0" max="5" step="0.5" value="2.5">
            </div>
            <button class="apply-button">적용하기</button>
        </div>
    </div>
    <div class="review-list">
        <jsp:include page="/reviewComponent.jsp" />
    </div>
</div>
</body>
</html>

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
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
    <div class="background-container">
        <jsp:include page="/navTabBar.jsp"/>
        <div class="review-card">
            <jsp:include page="/detailsComponent.jsp" />
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

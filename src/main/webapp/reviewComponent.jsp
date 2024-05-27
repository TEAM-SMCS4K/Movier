<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/20/24
  Time: 2:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/css/reviewComponent.css">
</head>
<body>
<div class="review">
    <div class="review-header">
        <p class="reviewer"><%= request.getParameter("reviewer") %></p>
        <div class="review-rating">
            <img src="img/icn_star_full.svg"/>
            <p class="rating"><%= request.getParameter("rating") %></p>
        </div>
    </div>
    <div class="review-date">
        <p><%= request.getParameter("date") %></p>
    </div>
    <div class="review-text">
        <p><%= request.getParameter("text") %></p>
    </div>
    <div class="review-actions">
        <p class="total-like"><%= request.getParameter("likes") %></p>
        <p class="like-comment">명이 공감해요!</p>
        <button class="like-button">공감해요</button>
    </div>
    <hr class="review-separator">
</div>
</body>
</html>

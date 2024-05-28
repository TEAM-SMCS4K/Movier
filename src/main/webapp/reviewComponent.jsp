<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/20/24
  Time: 2:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.SympathyDAO" %>
<html>
<head>
    <link rel="stylesheet" href="/css/reviewComponent.css">
</head>
<body>
<%
    boolean isSympathized = false;
    String message = "공감하기";
    if (session.getAttribute("member_id") != null) {
        int memberId = (int) session.getAttribute("member_id");
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        isSympathized = SympathyDAO.getInstance().isSympathyExist(memberId, reviewId);
        if (isSympathized) {
            message = "취소하기";
        }
    }
%>
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
        <button class="<%= isSympathized ? "dislike-button" : "like-button" %>"><%=message%></button>
    </div>
    <hr class="review-separator">
</div>
</body>
</html>

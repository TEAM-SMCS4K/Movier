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
    int memberId = -1;
    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    if (session.getAttribute("member_id") != null) {
        memberId = (int) session.getAttribute("member_id");
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $(".review-actions button").off("click").on("click", function (event) {
            event.preventDefault();
            var button = $(this);
            var memberId = <%=memberId %>;
            var reviewId = <%=reviewId%>

            if (memberId === -1) {
                alert("로그인 후 이용해주세요");
            } else {
                $.ajax({
                    url: "/toggle-sympathy",
                    type: "POST",
                    data: { memberId: memberId, reviewId: reviewId },
                    success: function (response) {
                        if (response.success) {
                            var totalLikes = button.closest(".review").find(".total-like");
                            if (response.isSympathized) {
                                button.removeClass("like-button").addClass("dislike-button").text("취소하기");
                            } else {
                                button.removeClass("dislike-button").addClass("like-button").text("공감하기");
                            }
                            totalLikes.text(response.totalLikes);
                        } else {
                            alert('공감 처리 중 오류가 발생했습니다.');
                        }
                    },
                    error: function () {
                        alert('서버와의 통신 중 오류가 발생했습니다.');
                    }
                });
            }
        });
    });
</script>
</body>
</html>

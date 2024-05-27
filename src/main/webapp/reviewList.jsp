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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            // 필터링 옵션 초기화
            let sortOption = "latest"; // 기본값: 최신순
            let minRating = 0; // 기본값: 0

            // 최신순 클릭 이벤트
            $("#sort-latest").click(function() {
                sortOption = "latest";
                $("#sort-latest").addClass("selected");
                $("#sort-rating").removeClass("selected");
                fetchReviews();
            });

            // 별점순 클릭 이벤트
            $("#sort-rating").click(function() {
                sortOption = "rating";
                $("#sort-latest").removeClass("selected");
                $("#sort-rating").addClass("selected");
                fetchReviews();
            });

            // 적용하기 버튼 클릭 이벤트
            $(".apply-button").click(function() {
                minRating = $("#review-slider").val();
                fetchReviews();
            });

            // 별점 필터 슬라이더 이벤트
            $("#review-slider").on("input", function() {
                minRating = $(this).val();
                $("#rating-value").text(minRating); // 슬라이더 값에 따라 rating-value 업데이트
            });

            // 리뷰 목록을 가져오는 함수
            function fetchReviews() {
                $.ajax({
                    url: "filterReviews.jsp",
                    type: "GET",
                    data: {
                        sortOption: sortOption,
                        minRating: minRating,
                        movieId: "<%= request.getParameter("movieId") %>"
                    },
                    success: function(response) {
                        $(".review-list").html(response);
                    },
                    error: function() {
                        alert("Error fetching data");
                    }
                });
            }

            // 페이지 로드 시 초기 리뷰 목록 가져오기
            fetchReviews();
        });
    </script>
</head>
<body>
<div class="review-list-section">
    <div class="review-list-title"><p>다른 사람의 리뷰</p></div>
    <div class="review-list-option">
        <div class="sort-area">
            <div id="sort-latest" class="filter-option selected"><p>최신순</p></div>
            <div id="sort-rating" class="filter-option"><p>별점순</p></div>
        </div>
        <div class="separator-area"><p>|</p></div>
        <div class="filter-area">
            <div class="filter-bar">
                <label for="review-slider" class="rating-label">별점 필터</label>
                <img src="img/icn_star_full.svg"/>
                <p id="rating-value">2.5</p>
                <input id="review-slider" type="range" min="0" max="5" step="0.5" value="2.5">
            </div>
            <button class="apply-button">적용하기</button>
        </div>
    </div>
    <div class="review-list">
    </div>
</div>
</body>
</html>

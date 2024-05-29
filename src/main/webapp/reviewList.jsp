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
            var $review_slider = $("#review-slider");
            $review_slider.val(0.0);
            $review_slider.removeClass("active");

            var sortOption = "latest"; // 기본값: 최신순
            var minRating = 0; // 기본값: 0

            var $sort_latest = $("#sort-latest");
            $sort_latest.addClass("selected");

            var $apply_button = $("#apply-button");
            $apply_button.addClass("disable-apply-button");

            var $filter_star = $("#filter-bar-star");
            $filter_star.attr("src", "img/icn_star_empty.svg")

            $("#sort-latest .check-icn").show();

            // 최신순 클릭 이벤트
            $sort_latest.click(function() {
                sortOption = "latest";
                $("#sort-rating").removeClass("selected");
                $("#sort-rating .check-icn").hide();
                $(this).addClass("selected");
                $("#sort-latest .check-icn").show();
                fetchReviews();
            });

            // 별점순 클릭 이벤트
            $("#sort-rating").click(function() {
                sortOption = "rating";
                $("#sort-latest").removeClass("selected");
                $("#sort-latest .check-icn").hide();
                $(this).addClass("selected");
                $("#sort-rating .check-icn").show();
                fetchReviews();
            });

            $("#filter-touch").click(function() {
                $(this).toggleClass("selected");

                if ($(this).hasClass("selected")) {
                    $("#filter-touch .check-icn").show();
                    $apply_button.removeClass("disable-apply-button").addClass("able-apply-button");
                    $filter_star.attr("src", "img/icn_star_full.svg")
                    $("#review-slider").addClass("active");
                } else {
                    $("#filter-touch .check-icn").hide();
                    $apply_button.removeClass("able-apply-button").addClass("disable-apply-button");
                    $filter_star.attr("src", "img/icn_star_empty.svg")
                    $("#review-slider").removeClass("active");
                    $review_slider.val(0.0);
                    $("#rating-value").text(0);
                    minRating = 0;
                    fetchReviews();
                }
            });

            // 적용하기 버튼 클릭 이벤트
            $("#apply-button").click(function() {
                minRating = $review_slider.val();
                fetchReviews();
            });

            // 별점 필터 슬라이더 이벤트
            $review_slider.on("input", function() {
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
            <div id="sort-latest"><img class="check-icn" src="img/icn_check.svg"/> <div><p>최신순</p></div></div>
            <div id="sort-rating"><img class="check-icn" src="img/icn_check.svg"/> <div><p>별점순</p></div></div>
        </div>
        <div class="separator-area"><p>|</p></div>
        <div class="filter-area">
            <div class="filter-bar">
                <div id="filter-touch"><img class="check-icn" src="img/icn_check.svg"/> <label for="review-slider" class="rating-label">별점 필터</label></div>
                <div class="filter-result"><img id="filter-bar-star" src="img/icn_star_full.svg"/>
                <p id="rating-value">0.0</p>
                </div>
                <input id="review-slider" type="range" min="0" max="5" step="0.5" value="2.5">
            </div>
            <button id="apply-button" class="disable-apply-button" onclick="">적용하기</button>
        </div>
    </div>
    <div class="review-list"></div>
</div>
</body>
</html>

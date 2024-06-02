<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.Review" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    boolean redirectToLogin = false;
    String alertMessage = "";
    int movieId = -1;
    String starRatingFormatted = "";

    if (memberId == null) {
        redirectToLogin = true;
        alertMessage = "로그인이 필요합니다";
    } else {
        MemberDAO memberDao = MemberDAO.getInstance();
        Member member = memberDao.getMemberById(memberId);
        if (member == null) {
            redirectToLogin = true;
            alertMessage = "잘못된 접근입니다";
        } else {
            ReviewDAO reviewDao = ReviewDAO.getInstance();
            Review review = reviewDao.getReviewById(reviewId);
            if (review == null) {
                redirectToLogin = true;
                alertMessage = "리뷰를 찾을 수 없습니다";
            } else {
                movieId = review.getMovieId();
                MovieDAO movieDao = MovieDAO.getInstance();
                Movie movie = movieDao.getMovieById(movieId);
                request.setAttribute("member", member);
                request.setAttribute("movie", movie);
                request.setAttribute("review", review);
            }
        }
    }
%>

<html>
<head>
    <title>Movier Review</title>
    <link rel="stylesheet" href="/css/writeReview.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        <% if (redirectToLogin) { %>
        alert("<%=alertMessage%>");
        window.location.href = 'socialLogin.jsp';
        <% } %>
    </script>
</head>
<body>
<%
    if (!redirectToLogin) {
        Movie movie = (Movie) request.getAttribute("movie");
        Review review = (Review) request.getAttribute("review");

        // 별점 포맷팅
        DecimalFormat df = new DecimalFormat("0.0");
        starRatingFormatted = df.format(review.getReviewRating());
%>
<div class="background-container" style="background: url(<%=movie.getThumbnailImg() %>)no-repeat center /cover">
    <jsp:include page="/navTabBar.jsp"/>
    <div class="review-card">
        <jsp:include page="/detailsComponent.jsp">
            <jsp:param name="movieId" value="<%= movieId %>" />
        </jsp:include>
        <div class="review-content">
            <form id="editForm">
                <input type="hidden" id="reviewId" name="reviewId" value="<%=reviewId%>">
                <input type="hidden" id="memberId" name="memberId" value="<%=memberId%>">
                <input type="hidden" id="movieId" name="movieId" value="<%=movieId%>">
                <h2>나의 별점</h2>
                <div class="rating">
                    <jsp:include page="/starRating.jsp"/>
                </div>
                <div class="review-input">
                    <label>
                        <textarea name='reviewContent' id ="reviewContent" rows="14" class="input-box"><%=review.getReviewContent()%></textarea>
                    </label>
                </div>
                <div class="review-submit">
                    <button type="submit" class="submit-button" id="submitReview">완료하기</button>
                </div>
            </form>
            <script>
                $(document).ready(function(){
                    var starRating = "<%= starRatingFormatted %>";  // 포맷된 별점 적용
                    let stars = document.querySelectorAll('.rating .star-icon');

                    if (starRating) {
                        document.getElementById('rating-number').textContent = starRating;
                        filledRate(starRating*2, stars.length);
                        clickRadioButtons(starRating);
                    }

                    function filledRate(index, length) {
                        if (index <= length) {
                            for (let i = 0; i < index; i++) {
                                stars[i].classList.add('filled');
                            }
                        }
                    }

                    function clickRadioButtons(starRating) {
                        var radioValue = String(starRating);
                        var radioButton = document.querySelector('.rating__input[value="' + radioValue + '"]');

                        if (radioButton) {
                            radioButton.checked = true;
                        }
                    }

                    $('.rating .rating__input').click(function(){
                        starRating = $(this).val();
                    });

                    $("#editForm").submit(function(event){
                        event.preventDefault(); // 폼 제출 막기
                        console.log('Submit button clicked');
                        const formData = {
                            reviewId: $("#reviewId").val(),
                            memberId: $("#memberId").val(),
                            movieId: $("#movieId").val(),
                            starRating: starRating,
                            reviewContent: $("#reviewContent").val()
                        };
                        console.log('Data:', formData);
                        $.ajax({
                            type: "PUT",
                            url: '/edit-review',
                            data: JSON.stringify(formData),
                            contentType: 'application/json; charset=UTF-8',
                            success: function(response){
                                console.log('AJAX 요청 성공');
                                alert("리뷰가 수정되었습니다.");
                                window.location.href = 'myReview.jsp?reviewId=' + $("#reviewId").val();
                            },
                            error: function(xhr){
                                const errorMessage = JSON.parse(xhr.responseText).message;
                                alert(errorMessage);
                            }
                        });
                    });
                });
            </script>
        </div>
    </div>
</div>
<% } %>
</body>
</html>

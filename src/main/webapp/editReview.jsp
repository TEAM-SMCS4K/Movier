<%--
  Created by IntelliJ IDEA.
  User: nache
  Date: 24. 5. 22.
  Time: 오후 7:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.Review" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    int reviewId = Integer.parseInt(request.getParameter("reviewId"));
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    boolean redirectToLogin = false;
    String alertMessage = "";

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
            MovieDAO movieDao = MovieDAO.getInstance();
            Movie movie = movieDao.getMovieById(movieId);
            ReviewDAO reviewDao = ReviewDAO.getInstance();
            Review review = reviewDao.getReviewById(reviewId);
            request.setAttribute("member", member);
            request.setAttribute("movie", movie);
            request.setAttribute("review", review);
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
%>
<div class="background-container" style="background: url(<%=movie.getThumbnailImg() %>)no-repeat center /cover">
    <jsp:include page="/navTabBar.jsp"/>
    <div class="review-card">
        <jsp:include page="/detailsComponent.jsp" />
        <div class="review-content">
            <form id="editForm">
                <input type="hidden" id="reviewId" name="reviewId" value="<%=reviewId%>">
                <input type="hidden" id="memberId" name="memberId" value="<%=memberId%>">
                <input type="hidden" id="movieId" name="movieId" value="<%=movieId%>">
                <h2>나의 별점</h2>
                <div class="rating">
                    <jsp:include page="/starRating.jsp"/>
                    <script>
                        $(document).ready(function(){
                            var starRating = <%=review.getReviewRating()%>;
                            $('.rating .rating__input[value="' + starRating + '"]').prop('checked', true);
                        });
                    </script>
                </div>
                <div class="review-input">
                    <label>
                        <textarea name='reviewContent' id ="reviewContent" cols="25" rows="20" class="input-box"><%=review.getReviewContent()%></textarea>
                    </label>
                </div>
                <div class="review-submit">
                    <button type="submit" class="submit-button" id="submitReview">완료하기</button>
                </div>
            </form>
            <script>
                $(document).ready(function(){
                    var starRating = <%=review.getReviewRating()%>;

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
                                window.location.href = 'myReview.jsp';
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
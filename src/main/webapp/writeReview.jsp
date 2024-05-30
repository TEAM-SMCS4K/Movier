<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    boolean redirectToLogin = false;
    String alertMessage = "";

    String placeholderText = null;
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
            request.setAttribute("member", member);
            request.setAttribute("movie", movie);
            placeholderText = movie.getTitle() + "에 대한 " + member.getNickname() + " 님의 생각을 써주세요!";
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
%>
<div class="background-container" style="background: url(<%=movie.getThumbnailImg() %>)no-repeat center /cover">
    <jsp:include page="/navTabBar.jsp"/>
    <div class="review-card">
        <%--        <jsp:include page="/detailsComponent.jsp" />--%>
        <div class="review-content">
            <form id="reviewForm">
                <input type="hidden" id="memberId" name="memberId" value="<%=memberId%>">
                <input type="hidden" id="movieId" name="movieId" value="<%=movieId%>">
                <h2>나의 별점</h2>
                <div class="rating">
                    <jsp:include page="/starRating.jsp"/>
                </div>
                <div class="review-input">
                    <label>
                        <textarea name='reviewContent' id ="reviewContent" cols="25" rows="20" class="input-box" placeholder="<%=placeholderText%>"></textarea>
                    </label>
                </div>
                <div class="review-submit">
                    <button type="submit" class="submit-button" id="submitReview">등록하기</button>
                </div>
            </form>
            <script>
                $(document).ready(function(){
                    $("#reviewForm").submit(function(event){
                        event.preventDefault(); // 폼 제출 막기
                        console.log('Submit button clicked');
                        const formData = {
                            memberId: $("#memberId").val(),
                            movieId: $("#movieId").val(),
                            starRating: $("input[name='starRating']:checked").val(),
                            reviewContent: $("#reviewContent").val()
                        };
                        console.log('Data:', formData);
                        $.ajax({
                            type: "POST",
                            url: '/write-review',
                            data: formData,
                            success: function(response){
                                console.log('AJAX 요청 성공');
                                alert("리뷰가 등록되었습니다.");
                                window.location.href = 'myPage.jsp';
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

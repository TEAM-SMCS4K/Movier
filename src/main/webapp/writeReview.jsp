<%--
  Created by IntelliJ IDEA.
  User: nache
  Date: 24. 5. 20.
  Time: 오후 4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.ReviewDAO" %>
<%@ page import="cs.sookmyung.movier.model.Review" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.Movie" %>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    Integer movieId = (Integer) session.getAttribute("movie_id");
    boolean redirectToLogin = false;
    String alertMessage = "";

    String placeholderText = null;
    Movie movie = null;
    if (memberId == null) {
        redirectToLogin = true;
        alertMessage = "로그인이 필요합니다";
    } else {
        MemberDAO memberDao = MemberDAO.getInstance();
        Member member = memberDao.getMemberById(memberId);
        MovieDAO movieDao = MovieDAO.getInstance();
        movie = movieDao.getMovieById(movieId);

        if (member == null || movie == null) {
            redirectToLogin = true;
            alertMessage = "잘못된 접근입니다";
        } else {
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
    <script>
        <% if (redirectToLogin) { %>
        alert("<%= alertMessage %>");
        window.location.href = 'socialLogin.jsp';
        <% } %>
    </script>
</head>
<body>
<div class="background-container" style="background: url(<%=movie.getThumbnailImg()%>)no-repeat center /cover">
    <jsp:include page="/navTabBar.jsp"/>
    <%
        if (!redirectToLogin) {
    %>
    <div class="review-card">
        <jsp:include page="/detailsComponent.jsp" />
        <div class="review-content">
            <form action="/writeReview" method="post">
                <h2>나의 별점</h2>
                <div class="rating">
                    <jsp:include page="/starRating.jsp"/>
                </div>
                <div class="review-input">
                    <label>
                        <textarea name='reviewContent' cols="30" rows="20" class="input-box" placeholder="<%=placeholderText%>"></textarea>
                    </label>
                </div>
                <div class="review-submit">
                    <button type="submit" class="submit-button">등록하기</button>
                </div>
            </form>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>

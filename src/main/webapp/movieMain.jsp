<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<html>
<head>
    <title>Main Movie List</title>
    <link rel="stylesheet" href="css/movieMain.css">
</head>
<body class="main-page">
<header>
    <jsp:include page="navTabBar.jsp"></jsp:include>

    <%
        Integer memberId = (Integer) session.getAttribute("member_id");
        boolean isLoggedIn = false;
        String alertMessage = "";

        if (memberId == null) {
            isLoggedIn = false;
        } else {
            MemberDAO memberDao = MemberDAO.getInstance();
            Member member = memberDao.getMemberById(memberId);
            if (member != null) {
                isLoggedIn = true;
                request.setAttribute("member", member);
            } else {
                isLoggedIn = false;
            }
        }
    %>

    <div id="profile_menu" class="profile_menu" style="display: none;">
        <%
            if (isLoggedIn) {
        %>
        <button id="mypage_button" onclick="goToMyPage()">마이페이지</button>
        <button id="logout_button" onclick="logout()">로그아웃</button>
        <%
        } else {
        %>
        <button id="login_button" onclick="login()">로그인</button>
        <%
            }
        %>
    </div>
</header>
<div class="main">
    <img src="img/movier_logo.svg" alt="logo" class="logo">
    <div class="searchBox">
        <img src="img/icn_search.svg" alt="search" class="search_icon">
        <input type="text" id="search_input" placeholder="영화의 제목을 입력하세요.">
    </div>
    <div class="movie_list">
        <span class="movie_list_title">무비차트</span>
        <div class="movie_list_grid">
            <% for (int i = 0; i < 30; i++) { %>
            <jsp:include page="movieListCell.jsp"></jsp:include>
            <% } %>
        </div>
    </div>
</div>

<script src="js/movieMain.js"></script>
</body>
</html>

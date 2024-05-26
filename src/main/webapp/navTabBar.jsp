<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<html>
<head>
    <link rel="stylesheet" href="/css/navTabBar.css">
</head>
<body>
<div class="nav_tab_var">
    <div class="movier-logo">
        <img src="img/movier_white_logo.svg" alt="Movier Logo">
    </div>
    <div class="profile" id="profile">
        <%
            Integer memberId = (Integer) session.getAttribute("member_id");
            boolean isLoggedIn = false;
            Member member = null;

            if (memberId != null) {
                MemberDAO memberDao = MemberDAO.getInstance();
                member = memberDao.getMemberById(memberId);
                if (member != null) {
                    isLoggedIn = true;
                    request.setAttribute("member", member);
                }
            }

            if (isLoggedIn) {
        %>
        <img src="<%= member.getProfileImg() != null ? member.getProfileImg() : "img/default_profile_img.svg" %>" class="profile_img" alt="Profile Picture">
        <p class="nickname"><%= member.getNickname() %> 님</p>
        <%
        } else {
        %>
        <img src="img/default_profile_img.svg" class="profile_img" alt="Default Profile Picture">
        <p class="nickname">로그인이 필요합니다</p>
        <%
            }
        %>
    </div>
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
</div>
<script src="/js/navTabBar.js"></script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<%@ page import="cs.sookmyung.movier.model.Member" %>
<html>
<head>
    <link rel="stylesheet" href="/css/navTabBar.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
</head>
<body>
<div class="nav_tab_var">
    <div class="movier-logo">
        <img src="img/movier_white_logo.svg" alt="Movier Logo" id="nav_logo_image" style="cursor:pointer;">
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
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const profile = document.getElementById("profile");
        const profileMenu = document.getElementById("profile_menu");
        const logoImage = document.getElementById("nav_logo_image");

        profile.addEventListener("click", function(event) {
            event.stopPropagation(); // 이벤트 버블링 방지
            profileMenu.style.display = profileMenu.style.display === "none" || profileMenu.style.display === "" ? "flex" : "none";
        });

        logoImage.addEventListener("click", function(event) {
            event.stopPropagation();
            window.location.href = "movieMain.jsp";
        });

        document.addEventListener("click", function() {
            profileMenu.style.display = "none";

            // 프로필 메뉴가 보일 때 커서를 기본 모양으로 변경
            if (profileMenu.style.display === "flex") {
                profile.style.cursor = "default";
            } else {
                profile.style.cursor = "pointer";
            }
        });

        document.addEventListener("click", function() {
            profileMenu.style.display = "none";
            profile.style.cursor = "pointer"; // 메뉴가 숨겨지면 커서를 클릭 가능하게 설정
        });

        profileMenu.addEventListener("click", function(event) {
            event.stopPropagation(); // 이벤트 버블링 방지
        });
    });

    function goToMyPage() {
        const profileMenu = document.getElementById("profile_menu");
        profileMenu.style.display = "none";
        window.location.href = "myPage.jsp"; // 마이페이지
    }

    function logout() {
        alert("로그아웃합니다.");
        <%
         // 세션 무효화
        session.invalidate();
        %>
        window.location.href = "movieMain.jsp"; // 메인 페이지
    }

    function login() {
        const profileMenu = document.getElementById("profile_menu");
        profileMenu.style.display = "none";
        window.location.href = "socialLogin.jsp"; // 소셜로그인 페이지
    }
</script>
</body>
</html>

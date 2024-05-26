document.addEventListener("DOMContentLoaded", function() {
    const profile = document.getElementById("profile");
    const profileMenu = document.getElementById("profile_menu");

    profile.addEventListener("click", function(event) {
        event.stopPropagation(); // 이벤트 버블링 방지
        profileMenu.style.display = profileMenu.style.display === "none" || profileMenu.style.display === "" ? "flex" : "none";
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
    // 실제로 로그아웃하는 코드를 여기에 작성
    // 예: window.location.href = 'logout.jsp';
}

function login() {
    const profileMenu = document.getElementById("profile_menu");
    profileMenu.style.display = "none";
    window.location.href = "socialLogin.jsp"; // 소셜로그인 페이지
}

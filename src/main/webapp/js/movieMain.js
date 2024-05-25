document.addEventListener("DOMContentLoaded", function() {
    const profile = document.getElementById("profile");
    const profileMenu = document.getElementById("profile_menu");

    // 특정 페이지에서만 활성화
    const specificPageClass = "main-page"; // 해당 클래스가 있는 페이지에서만 작동

    if (document.body.classList.contains(specificPageClass)) {
    profile.addEventListener("click", function(event) {
    event.stopPropagation(); // 이벤트 버블링 방지
    profileMenu.style.display = profileMenu.style.display === "none" || profileMenu.style.display === "" ? "block" : "none";
});

    document.addEventListener("click", function() {
    profileMenu.style.display = "none";
});

    profileMenu.addEventListener("click", function(event) {
    event.stopPropagation(); // 이벤트 버블링 방지
});
}
});

    function goToMyPage() {
    alert("마이페이지로 이동합니다.");
    // 실제로 마이페이지로 이동하는 코드를 여기에 작성
}

    function logout() {
    alert("로그아웃합니다.");
    // 실제로 로그아웃하는 코드를 여기에 작성
}
document.addEventListener("DOMContentLoaded", function() {
    const profile = document.getElementById("profile");
    const profileMenu = document.getElementById("profile_menu");

    // 특정 페이지에서만 활성화
    const specificPageClass = "main-page"; // 해당 클래스가 있는 페이지에서만 작동

    if (document.body.classList.contains(specificPageClass)) {
        profile.addEventListener("click", function(event) {
            event.stopPropagation(); // 이벤트 버블링 방지
            profileMenu.style.display = profileMenu.style.display === "none" || profileMenu.style.display === "" ? "flex" : "none";
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
    const profileMenu = document.getElementById("profile_menu");
    profileMenu.style.display = "none";
    window.location.href = "myPage.jsp"; // 마이페이지
}

function logout() {
    alert("로그아웃합니다.");
}

function login() {
    window.location.href = 'login.jsp';
    const profileMenu = document.getElementById("profile_menu");
    profileMenu.style.display = "none";
    window.location.href = "socialLogin.jsp"; // 소셜로그인 페이지
}

// 검색
document.addEventListener("DOMContentLoaded", function() {
    const searchInput = document.getElementById("search_input");
    const movieListTitle = document.querySelector(".movie_list_title");

    // 검색 실행 함수
    function performSearch() {
        const searchQuery = searchInput.value.trim();
        if (searchQuery !== "") {
            movieListTitle.textContent = `'${searchQuery}'에 대한 검색결과`;
            // 검색결과 출력 -> 서버 통신
            // fetch(`search?query=${searchQuery}`)
            //     .then(response => response.text())
            //     .then(data => {
            //         document.getElementById("movie_list_grid").innerHTML = data;
            //         document.querySelector(".movie_list_title").textContent = `검색 결과: ${searchQuery}`;
            //     })
            //     .catch(error => console.error('Error:', error));
        } else {
            alert("검색어를 입력해주세요.");
        }
    }

    // 엔터키 입력 시 검색 실행
    searchInput.addEventListener("keyup", function(event) {
        if (event.keyCode === 13) { // Enter key code
            performSearch();
        }
    });
});








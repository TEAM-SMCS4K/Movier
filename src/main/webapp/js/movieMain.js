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








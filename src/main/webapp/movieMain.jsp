<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.MovieList" %>
<%
    MovieDAO movieDAO = MovieDAO.getInstance();
    List<MovieList> movieList = movieDAO.getMovieList();
    request.setAttribute("movieList", movieList);
%>
<html>
<head>
    <title>Main Movie List</title>
    <link rel="stylesheet" href="css/movieMain.css">
    <link href="https://cdn.jsdelivr.net/gh/sun-typeface/SUIT/fonts/static/woff2/SUIT.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="main-page">
<header>
    <jsp:include page="navTabBar.jsp"/>
</header>
<div class="main">
    <img src="img/movier_logo.svg" alt="logo" class="logo" id="logo_image" style="cursor:pointer;" >
    <div class="searchBox">
        <img src="img/icn_search.svg" alt="search" class="search_icon">
        <input type="text" id="search_input" placeholder="영화의 제목을 입력하세요.">
    </div>
    <div class = "separator-movie-list">
        <div class="movie_list">
            <jsp:include page="movieLists.jsp"/>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        const searchInput = document.getElementById("search_input");
        const logoImage = document.getElementById("logo_image")

        // 검색 실행 함수
        function performSearch() {
            const searchQuery = searchInput.value.trim();
            if (searchQuery !== "") {
                fetchMovies(searchQuery);
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

        // 여기부텅
        function fetchMovies(searchQuery) {
            $.ajax({
                url: "searchMovieLists.jsp",
                type: "GET",
                data: { keyword: searchQuery },
                success: function(response) {
                    $(".movie_list").html(response); // 영화 리스트 업데이트
                    $(".movie_list_title").text("'" + searchQuery + "'에 대한 검색결과"); // title 업데이트
                },
                error: function(xhr, status, error) {
                    alert("검색 과정에서 오류가 발생했습니다.\n" + xhr.responseText);
                }
            });
        }

        logoImage.addEventListener("click", function() {
            location.reload();
        });
    });
</script>
</body>
</html>
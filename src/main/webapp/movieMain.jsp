<%--
  Created by IntelliJ IDEA.
  User: kwonjeong
  Date: 5/20/24
  Time: 2:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Main Movie List</title>
    <link rel="stylesheet" href="css/movieMain.css">
</head>
<body>
<header>
    <jsp:include page="navTabBar.jsp"></jsp:include>
</header>
<div class="main">
    <img src="img/movier_logo.svg" alt="logo" class="logo">
    <button id="search_button">search</button>
    <input type="text" id="search_input" placeholder="영화의 제목을 입력하세요.">
    <div class="movie_list">
        <span class="title">무비차트</span>
        <div class="movie_list_cell">
<%--            영화 리스트--%>
        </div>
    </div>
</div>
</body>
</html>

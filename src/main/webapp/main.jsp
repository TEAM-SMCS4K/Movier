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
</head>
<body>
<jsp:include page="/navTabBar.jsp"></jsp:include>
<div class="main">
    <img src="../img/movier_logo.svg" alt="logo" class="logo">
    <input type="text" id="search_input" placeholder="영화의 제목을 입력하세요.">
</div>
</body>
</html>

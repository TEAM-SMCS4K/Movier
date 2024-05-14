<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/14/24
  Time: 11:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.config.ConfigLoader "%>
<%
    String KAKAO_APP_KEY = ConfigLoader.getInstance().getKey("kakao.clientId");
    String KAKAO_REDIRECT_URI = ConfigLoader.getInstance().getKey("kakao.redirectUri");
%>
<html>
<head>
    <title>socialLogin</title>
    <link rel="stylesheet" href="css/socialLogin.css">
</head>
<body>
    <div class="container">
        <img src="img/movier_logo.svg" alt="Movier Logo" class="movier-logo">
        <p>영화의 마음을 함께하는 공간</p>
        <a href="https://kauth.kakao.com/oauth/authorize?client_id=<%=KAKAO_APP_KEY%>&redirect_uri=<%=KAKAO_REDIRECT_URI%>&response_type=code" class="kakao-login-btn">
            <img src="img/kakao_logo.svg" alt="카카오톡으로 로그인" class="kakao-logo"> 카카오톡으로 로그인
        </a>
    </div>
</body>
</html>

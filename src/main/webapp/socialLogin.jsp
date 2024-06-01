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
%>
<html>
<head>
    <title>Movier</title>
    <link rel="stylesheet" href="css/socialLogin.css">
    <meta charset="UTF-8">
    <title>Movier</title>
    <link rel="stylesheet" href="css/socialLogin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script type="text/javascript">
        Kakao.init('<%= KAKAO_APP_KEY %>');
        function kakaoLogin() {
            Kakao.Auth.login({
                success: function (authObj) {
                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function (response) {
                            $.ajax({
                                type: 'POST',
                                url: '/social-login',
                                data: {
                                    social_platform_id: response.id,
                                    nickname: response.properties.nickname,
                                    profile_img: response.properties.profile_image
                                },
                                success: function (data) {
                                    window.location.href = 'index.jsp';
                                },
                                error: function (xhr, status, error) {
                                    alert('로그인에 실패했습니다 다시 시도해주세요');
                                    window.location.href = 'socialLogin.jsp';
                                }
                            });
                        },
                        fail: function (error) {
                            alert('로그인에 실패했습니다 다시 시도해주세요');
                            window.location.href = 'socialLogin.jsp';
                        }
                    });
                },
                fail: function (error) {
                    alert('로그인에 실패했습니다 다시 시도해주세요');
                    window.location.href = 'socialLogin.jsp';
                }
            });
        }
    </script>
</head>
<body>
<div class="container">
    <img src="img/movier_logo.svg" alt="Movier Logo" class="movier-logo">
    <p>영화와 마음을 함께하는 공간</p>
    <a href="javascript:kakaoLogin();" class="kakao-login-btn">
        <img src="img/kakao_logo.svg" alt="카카오톡으로 로그인" class="kakao-logo"> 카카오톡으로 로그인
    </a>
</div>
</body>
</html>
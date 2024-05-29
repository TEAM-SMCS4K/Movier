<%--
  Created by IntelliJ IDEA.
  User: kim-sung-eun
  Date: 5/20/24
  Time: 9:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cs.sookmyung.movier.dao.MemberDAO" %>
<html>
<head>
    <title>Movier</title>
    <link rel="stylesheet" href="/css/reviewRequest.css">
</head>
<body>
<%
    Integer memberId = (Integer) session.getAttribute("member_id");
    boolean isLoggedIn = memberId != null;
    String message = "리뷰를 작성하기 위해 로그인을 해주세요!";
    String buttonText = "로그인하기";
    if(isLoggedIn){
        String userName = MemberDAO.getInstance().getMemberNameById(memberId);
        message = userName + "님의 의견도 알려주세요!";
        buttonText = "리뷰 작성하기";
    }
%>
<div class="review-request">
    <p><span>범죄도시 4</span> 재미있게 보셨나요?<br> <%= message %></p>
    <button class="<%= isLoggedIn ? "review-request-button" : "login-request-button" %>" onclick="handleButtonClick()"><%= buttonText %></button>
</div>
<script type="text/javascript">
    function handleButtonClick() {
        var button = document.querySelector(".review-request button");
        if (button.classList.contains("login-request-button")) {
            window.location.href = "/socialLogin.jsp";
        } else if (button.classList.contains("review-request-button")) {
            window.location.href = "/writeReview.jsp?movieId=<%=request.getParameter("movieId")%>";
        }
    }
</script>
</body>
</html>

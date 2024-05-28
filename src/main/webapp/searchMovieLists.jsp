<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.MovieList" %>
<%
    try {
        String keyword = request.getParameter("keyword");
        MovieDAO movieDAO = MovieDAO.getInstance();
        List<MovieList> movieList = movieDAO.getSearchMovies(keyword);
        request.setAttribute("movieList", movieList);
    } catch (Exception e) {
        e.printStackTrace();  // 콘솔에 오류 출력
        throw new ServletException("Error processing request", e);
    }
%>
<jsp:include page="movieLists.jsp"/>

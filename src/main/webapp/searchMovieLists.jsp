<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cs.sookmyung.movier.dao.MovieDAO" %>
<%@ page import="cs.sookmyung.movier.model.MovieList" %>
<%
    String keyword = request.getParameter("keyword");
    MovieDAO movieDAO = MovieDAO.getInstance();
    List<MovieList> movieList = movieDAO.getSearchMovies(keyword);
    request.setAttribute("movieList", movieList);
%>
<jsp:include page="movieLists.jsp"/>

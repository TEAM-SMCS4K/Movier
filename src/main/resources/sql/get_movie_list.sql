CREATE OR REPLACE PROCEDURE get_movie_list_cursor (
    movie_list_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN movie_list_cursor FOR
        SELECT
            movie_id AS id,
            movie_name AS title,
            movie_poster_img AS posterImg,
            movie_review_average_rating AS rating,
            movie_review_count AS review_count
        FROM
            movies;
END;
/
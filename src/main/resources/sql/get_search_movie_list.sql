CREATE OR REPLACE PROCEDURE get_search_movie_list_cursor (
    keyword IN VARCHAR2,
    movie_list_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN movie_list_cursor FOR
        SELECT
            m.movie_id AS id,
            m.movie_name AS title,
            m.movie_poster_img AS posterImg,
            NVL(AVG(r.review_rating), 0) AS rating,
            NVL(COUNT(r.review_id), 0) AS review_count
        FROM
            movies m
                LEFT JOIN
            reviews r ON m.movie_id = r.movie_id
        WHERE
            UPPER(m.movie_name) LIKE '%' || UPPER(keyword) || '%'
        GROUP BY
            m.movie_id, m.movie_name, m.movie_poster_img;
END;
/


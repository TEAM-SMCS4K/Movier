CREATE OR REPLACE PROCEDURE get_movie_info_by_review_id (
    p_review_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT m.movie_id,
               m.movie_name,
               m.movie_poster_img,
               m.movie_genre,
               m.movie_release_date,
               m.movie_running_time
        FROM reviews r
                 JOIN movies m ON r.movie_id = m.movie_id
        WHERE r.review_id = p_review_id;
END;
/

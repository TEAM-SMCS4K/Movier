CREATE OR REPLACE PROCEDURE get_movie_info_by_movie_id (
    p_movie_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT movie_id,
               movie_name,
               movie_poster_img,
               movie_genre,
               movie_release_date,
               movie_running_time
        FROM movies
        WHERE movie_id = p_movie_id;
END;
/
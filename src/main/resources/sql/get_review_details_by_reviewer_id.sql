CREATE OR REPLACE PROCEDURE get_review_details_by_reviewer_id (
    p_review_id IN NUMBER,
    p_reviewer_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT r.review_id,
               r.reviewer_id,
               r.movie_id,
               r.review_rating,
               r.review_content,
               r.review_created_at,
               m.movie_thumbnail_img,
               m.movie_name,
               m.movie_genre,
               m.movie_release_date,
               m.movie_running_time,
               m.movie_poster_img
        FROM reviews r
                 JOIN movies m ON r.movie_id = m.movie_id
        WHERE r.review_id = p_review_id
          AND r.reviewer_id = p_reviewer_id;
END;
/

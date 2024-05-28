CREATE OR REPLACE PROCEDURE get_reviews_by_reviewer_id (
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
               (SELECT m.movie_poster_img FROM movies m WHERE m.movie_id = r.movie_id) AS movie_poster_img,
               (SELECT m.movie_name FROM movies m WHERE m.movie_id = r.movie_id) AS movie_name
        FROM reviews r
        WHERE r.reviewer_id = p_reviewer_id
        ORDER BY r.review_created_at DESC;
END;
/

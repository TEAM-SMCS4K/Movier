CREATE OR REPLACE PROCEDURE get_reviews_by_member_id (
    p_member_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT r.review_id,
               r.member_id,
               r.movie_id,
               r.review_rating,
               r.review_content,
               r.review_created_at,
               (SELECT m.movie_poster_img FROM movies m WHERE m.movie_id = r.movie_id) AS movie_poster_img,
               (SELECT m.movie_name FROM movies m WHERE m.movie_id = r.movie_id) AS movie_name
        FROM reviews r
        WHERE r.member_id = p_member_id
        ORDER BY r.review_created_at DESC;
END;
/
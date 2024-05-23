CREATE OR REPLACE PROCEDURE get_reviews_by_member_id (
    p_member_id IN NUMBER,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT r.review_id,
               r.review_content,
               r.review_rating,
               r.review_created_at,
               m.movie_name,
               m.movie_poster_img
        FROM reviews r
                 JOIN movies m ON r.movie_id = m.movie_id
        WHERE r.member_id = p_member_id
        ORDER BY r.review_created_at DESC;
END;
/

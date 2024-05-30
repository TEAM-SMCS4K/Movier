CREATE OR REPLACE PROCEDURE get_rating_reviews_by_movie_id (
    p_movie_id IN reviews.movie_id%TYPE,
    p_min_rating IN reviews.review_rating%TYPE,
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR
    SELECT review_id, movie_id, reviewer_id, review_content, review_rating, review_created_at
    FROM reviews
    WHERE movie_id = p_movie_id AND review_rating >= p_min_rating
    ORDER BY review_rating DESC;
END;
/
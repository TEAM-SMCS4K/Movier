CREATE OR REPLACE PROCEDURE insert_review(
    p_reviewer_id IN NUMBER,
    P_movie_id IN NUMBER,
    p_review_rating IN NUMBER,
    p_review_content IN VARCHAR2,
    p_review_created_at IN DATE,
    p_review_id OUT NUMBER
) AS
    rating_null_error EXCEPTION;
    content_null_error EXCEPTION;
BEGIN
    IF p_review_rating IS NULL OR p_review_rating = 0 THEN
        RAISE rating_null_error;
    END IF;

    IF p_review_content IS NULL OR TRIM(p_review_content) IS NULL THEN
        RAISE content_null_error;
    END IF;

    INSERT INTO reviews (REVIEWER_ID, MOVIE_ID, REVIEW_RATING, REVIEW_CONTENT, REVIEW_CREATED_AT)
    VALUES (p_reviewer_id, P_movie_id, p_review_rating, p_review_content, p_review_created_at)
    RETURNING REVIEW_ID INTO p_review_id;
EXCEPTION
    WHEN rating_null_error THEN
        RAISE_APPLICATION_ERROR(-20001, '별점이 입력되지 않았습니다.');
    WHEN content_null_error THEN
        RAISE_APPLICATION_ERROR(-20003, '리뷰 내용이 입력되지 않았습니다.');
    WHEN OTHERS THEN
        RAISE;
END;
/

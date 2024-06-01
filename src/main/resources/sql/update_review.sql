CREATE OR REPLACE PROCEDURE update_review(
    p_review_id IN NUMBER,
    p_reviewer_id IN NUMBER,
    P_movie_id IN NUMBER,
    p_review_rating IN NUMBER,
    p_review_content IN VARCHAR2,
    p_review_created_at IN DATE
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

    UPDATE REVIEWS
    SET REVIEW_RATING = p_review_rating,
        REVIEW_CONTENT = p_review_content,
        REVIEW_CREATED_AT = p_review_created_at
    WHERE REVIEW_ID = p_review_id AND REVIEWER_ID = p_reviewer_id AND MOVIE_ID = P_movie_id;

    COMMIT;

EXCEPTION
    WHEN rating_null_error THEN
        RAISE_APPLICATION_ERROR(-20001, '별점이 입력되지 않았습니다.');
    WHEN content_null_error THEN
        RAISE_APPLICATION_ERROR(-20003, '리뷰 내용이 입력되지 않았습니다.');
    WHEN OTHERS THEN
        RAISE;
END;
/
CREATE OR REPLACE PROCEDURE insert_review(
    p_member_id IN NUMBER,
    p_movie_id IN NUMBER,
    p_review_rating IN NUMBER,
    p_review_content IN VARCHAR2,
    p_review_created_at IN DATE,
    p_review_id OUT NUMBER
) AS
    -- NOT NULL 제약 조건 위반에 대한 사용자 정의 예외
    ex_not_null_violation EXCEPTION;
    PRAGMA EXCEPTION_INIT(ex_not_null_violation, -1400);
BEGIN
    INSERT INTO reviews (MEMBER_ID, MOVIE_ID, REVIEW_RATING, REVIEW_CONTENT, REVIEW_CREATED_AT)
    VALUES (p_member_id, p_movie_id, p_review_rating, p_review_content, p_review_created_at)
    RETURNING REVIEW_ID INTO p_review_id;
EXCEPTION
    WHEN ex_not_null_violation THEN
        p_review_id := NULL;
        RAISE_APPLICATION_ERROR(-20001, '리뷰를 입력해주세요.');
    WHEN OTHERS THEN
        p_review_id := NULL;
        RAISE;
END;
/
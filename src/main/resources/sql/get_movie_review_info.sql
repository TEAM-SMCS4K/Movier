CREATE OR REPLACE FUNCTION get_movie_review_info(movie_id IN NUMBER)
RETURN SYS_REFCURSOR IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_review_count MOVIES.MOVIE_REVIEW_COUNT%TYPE;
    v_total_rating MOVIES.MOVIE_REVIEW_AVERAGE_RATING%TYPE;
    cur SYS_REFCURSOR;
BEGIN
    -- 리뷰 개수와 총 별점 합 계산
SELECT COUNT(*), NVL(SUM(REVIEW_RATING), 0)
INTO v_review_count, v_total_rating
FROM REVIEWS
WHERE MOVIE_ID = movie_id;

-- 커서에 결과를 담아서 반환
OPEN cur FOR SELECT v_review_count AS review_count, v_total_rating AS total_rating FROM DUAL;

RETURN cur;
END;
/
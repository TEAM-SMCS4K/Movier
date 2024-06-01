CREATE OR REPLACE TRIGGER trg_review_changes
AFTER INSERT OR UPDATE OR DELETE ON reviews
    FOR EACH ROW
DECLARE
    v_review_count MOVIES.MOVIE_REVIEW_COUNT%TYPE;
    v_total_rating MOVIES.MOVIE_REVIEW_AVERAGE_RATING%TYPE;
    cur SYS_REFCURSOR;
BEGIN
    IF INSERTING OR UPDATING THEN
        -- 독립적인 트랜잭션 함수를 호출하여 커서를 얻음
        cur := get_movie_review_info(:NEW.movie_id);
ELSE
        -- 독립적인 트랜잭션 함수를 호출하여 커서를 얻음
        cur := get_movie_review_info(:OLD.movie_id);
END IF;

    -- 커서에서 값 추출
FETCH cur INTO v_review_count, v_total_rating;
CLOSE cur;

-- 영화 테이블 업데이트
UPDATE MOVIES
SET MOVIE_REVIEW_COUNT = v_review_count,
    MOVIE_REVIEW_AVERAGE_RATING = CASE WHEN v_review_count = 0 THEN 0 ELSE v_total_rating / v_review_count END
WHERE MOVIE_ID = CASE WHEN INSERTING OR UPDATING THEN :NEW.movie_id ELSE :OLD.movie_id END;
END;
/

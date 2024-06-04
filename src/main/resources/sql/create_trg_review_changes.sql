CREATE OR REPLACE TRIGGER trg_review_changes
AFTER INSERT OR UPDATE OR DELETE ON reviews
    FOR EACH ROW
DECLARE
    v_review_count NUMBER;
    v_total_rating NUMBER;
    v_movie_id MOVIES.MOVIE_ID%TYPE;
    cur SYS_REFCURSOR;
BEGIN
    IF INSERTING THEN
    v_movie_id := :NEW.movie_id;
    ELSIF UPDATING THEN
    v_movie_id := :NEW.movie_id;
    ELSE
    v_movie_id := :OLD.movie_id;
    END IF;

    cur := get_movie_review_info(v_movie_id);

    -- 커서에서 값 추출
    FETCH cur INTO v_review_count, v_total_rating;
    CLOSE cur;

-- 영화 테이블 업데이트
    UPDATE MOVIES
    SET MOVIE_REVIEW_COUNT = v_review_count,
        MOVIE_REVIEW_AVERAGE_RATING = CASE WHEN v_review_count = 0 THEN 0 ELSE v_total_rating / v_review_count END
    WHERE MOVIE_ID = v_movie_id;
END;
/
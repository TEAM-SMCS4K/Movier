CREATE OR REPLACE TRIGGER trg_review_insert
    AFTER INSERT ON reviews
    FOR EACH ROW
DECLARE
    v_review_count NUMBER;
    v_total_rating NUMBER;
BEGIN
    -- 리뷰 개수와 총 별점 합 계산
    SELECT COUNT(*), NVL(SUM(review_rating), 0)
    INTO v_review_count, v_total_rating
    FROM reviews
    WHERE movie_id = :NEW.movie_id;

    -- 영화 테이블 업데이트
    UPDATE movies
    SET movie_review_count = v_review_count,
        movie_review_average_rating = v_total_rating / v_review_count
    WHERE movie_id = :NEW.movie_id;
END;
/

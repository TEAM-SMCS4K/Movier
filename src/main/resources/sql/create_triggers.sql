-- 영화 테이블에 리뷰 개수, 평점 컬럼 추가
ALTER TABLE movies
    ADD (
        review_count NUMBER DEFAULT 0,
        average_rating NUMBER DEFAULT 0
        );

-- 리뷰 작성 시 트리거
CREATE OR REPLACE TRIGGER trg_update_movie_reviews
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
    SET review_count = v_review_count,
        average_rating = v_total_rating / v_review_count
    WHERE movie_id = :NEW.movie_id;
END;
/

-- 리뷰 수정 시 트리거
CREATE OR REPLACE TRIGGER trg_update_movie_reviews_after_update
    AFTER UPDATE ON reviews
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
    SET review_count = v_review_count,
        average_rating = CASE WHEN v_review_count = 0 THEN 0 ELSE v_total_rating / v_review_count END
    WHERE movie_id = :NEW.movie_id;
END;
/

-- 리뷰 삭제 시 트리거
CREATE OR REPLACE TRIGGER trg_update_movie_reviews_after_delete
    AFTER DELETE ON reviews
    FOR EACH ROW
DECLARE
    v_review_count NUMBER;
    v_total_rating NUMBER;
BEGIN
    -- 리뷰 개수와 총 별점 합 계산
    SELECT COUNT(*), NVL(SUM(review_rating), 0)
    INTO v_review_count, v_total_rating
    FROM reviews
    WHERE movie_id = :OLD.movie_id;

    -- 영화 테이블 업데이트
    UPDATE movies
    SET review_count = v_review_count,
        average_rating = CASE WHEN v_review_count = 0 THEN 0 ELSE v_total_rating / v_review_count END
    WHERE movie_id = :OLD.movie_id;
END;
/
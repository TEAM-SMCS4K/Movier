CREATE OR REPLACE PROCEDURE check_sympathy(
    p_user_id IN sympathy.user_id%TYPE,
    p_review_id IN sympathy.review_id%TYPE,
    p_result OUT BOOLEAN -- 반환값으로 사용할 OUT 매개변수 추가
) AS
    v_review sympathy%ROWTYPE;
BEGIN
SELECT * INTO v_review
FROM user_review_likes
WHERE user_id = p_user_id AND review_id = p_review_id;

IF v_review.user_id IS NOT NULL AND v_review.review_id IS NOT NULL THEN
        p_result := TRUE; -- 공감한 경우
ELSE
        p_result := FALSE; -- 공감하지 않은 경우
END IF;
END;
/
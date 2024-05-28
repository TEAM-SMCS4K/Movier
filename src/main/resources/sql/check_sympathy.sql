CREATE OR REPLACE PROCEDURE check_sympathy(
    member_id IN sympathy.p_member_id%TYPE,
    review_id IN sympathy.p_review_id%TYPE,
    p_result OUT BOOLEAN -- 반환값으로 사용할 OUT 매개변수 추가
) AS
    v_review sympathy%ROWTYPE;
BEGIN
SELECT * INTO v_review
FROM SYMPATHY
WHERE  P_MEMBER_ID = member_id AND p_review_id = review_id;

IF v_review.P_MEMBER_ID IS NOT NULL AND v_review.P_REVIEW_ID IS NOT NULL THEN
        p_result := TRUE; -- 공감한 경우
ELSE
        p_result := FALSE; -- 공감하지 않은 경우
END IF;
END;
/
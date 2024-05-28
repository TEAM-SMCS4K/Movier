CREATE OR REPLACE PROCEDURE check_sympathy(
    member_id IN sympathy.p_member_id%TYPE,
    review_id IN sympathy.p_review_id%TYPE,
    p_result OUT NUMBER -- BOOLEAN 대신 NUMBER 사용
) AS
    v_sympathy sympathy%ROWTYPE;
BEGIN
    BEGIN
        SELECT * INTO v_sympathy
        FROM sympathy
        WHERE p_member_id = member_id AND p_review_id = review_id;

        IF v_sympathy.p_member_id IS NOT NULL AND v_sympathy.p_review_id IS NOT NULL THEN
            p_result := 1; -- 공감한 경우 1
        ELSE
            p_result := 0; -- 공감하지 않은 경우 0
        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                p_result := 0; -- 공감하지 않은 경우 0
    END;
END;
/

CREATE OR REPLACE PROCEDURE check_sympathy(
    member_id IN sympathy.p_member_id%TYPE,
    review_id IN sympathy.p_review_id%TYPE,
    p_result OUT NUMBER -- BOOLEAN 대신 NUMBER 사용
) AS
    v_sympathy sympathy%ROWTYPE;
BEGIN
    -- 입력값 검증
    IF member_id IS NULL OR member_id <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid member_id: ' || TO_CHAR(member_id));
    ELSIF review_id IS NULL OR review_id <= 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Invalid review_id: ' || TO_CHAR(review_id));
    END IF;
    -- 공감 여부 확인
    BEGIN
        SELECT * INTO v_sympathy
        FROM sympathy
        WHERE p_member_id = member_id AND p_review_id = review_id;
        p_result := 1; -- 공감한 경우 1

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_result := 0; -- 공감하지 않은 경우 0
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'An unexpected error occurred: ' || SQLERRM);
    END;
END;
/

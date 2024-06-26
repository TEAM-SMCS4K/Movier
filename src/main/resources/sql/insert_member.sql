CREATE OR REPLACE PROCEDURE insert_member(
    p_member_name IN members.member_name%TYPE,
    p_kakao_platform_id IN members.kakao_platform_id%TYPE,
    p_member_profile_img IN members.member_profile_img%TYPE,
    p_member_id OUT NUMBER
) AS
    INVALID_MEMBER_NAME EXCEPTION;
    INVALID_KAKAO_PLATFORM_ID EXCEPTION;
BEGIN
    -- 입력값 검증
    IF p_member_name IS NULL OR LENGTH(TRIM(p_member_name)) = 0 THEN
        RAISE INVALID_MEMBER_NAME;
    ELSIF p_kakao_platform_id IS NULL OR LENGTH(TRIM(p_kakao_platform_id)) = 0 THEN
        RAISE INVALID_KAKAO_PLATFORM_ID;
    END IF;

    -- 멤버 삽입
    INSERT INTO members (member_name, kakao_platform_id, member_profile_img)
    VALUES (p_member_name, p_kakao_platform_id, p_member_profile_img)
    RETURNING member_id INTO p_member_id;

    EXCEPTION
        WHEN INVALID_MEMBER_NAME THEN
            RAISE_APPLICATION_ERROR(-20002, 'Invalid member_name: ' || p_member_name);
        WHEN INVALID_KAKAO_PLATFORM_ID THEN
            RAISE_APPLICATION_ERROR(-20003, 'Invalid kakao_platform_id: ' || p_kakao_platform_id);
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error inserting member: ' || SQLERRM);
END;
/
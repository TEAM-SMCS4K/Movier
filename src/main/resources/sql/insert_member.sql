CREATE OR REPLACE PROCEDURE insert_member(
    p_member_name IN VARCHAR2,
    p_kakao_platform_id IN VARCHAR2,
    p_member_profile_img IN VARCHAR2,
    p_member_id OUT NUMBER
) AS
BEGIN
INSERT INTO members (member_name, kakao_platform_id, member_profile_img)
VALUES (p_member_name, p_kakao_platform_id, p_member_profile_img)
    RETURNING member_id INTO p_member_id;
EXCEPTION
        WHEN OTHERS THEN
            p_member_id := NULL;
            RAISE;
END;
/
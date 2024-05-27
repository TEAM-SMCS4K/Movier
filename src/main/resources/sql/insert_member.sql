CREATE OR REPLACE PROCEDURE insert_member(
    p_member_name IN members.member_name%TYPE,
    p_kakao_platform_id IN members.kakao_platform_id%TYPE,
    p_member_profile_img IN members.member_profile_img%TYPE,
    p_member_id OUT NUMBER
) AS
BEGIN
INSERT INTO members (member_name, kakao_platform_id, member_profile_img)
VALUES (p_member_name, p_kakao_platform_id, p_member_profile_img)
    RETURNING member_id INTO p_member_id;
EXCEPTION
        WHEN OTHERS THEN
            p_member_id := -1;
            RAISE_APPLICATION_ERROR(-20002, 'Error inserting member: ' || SQLERRM);
END;
/

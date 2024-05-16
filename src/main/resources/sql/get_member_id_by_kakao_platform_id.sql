CREATE OR REPLACE FUNCTION get_member_id_by_kakao_platform_id(
    p_kakao_platform_id IN VARCHAR2
) RETURN NUMBER IS
    v_member_id NUMBER;
BEGIN
SELECT member_id
INTO v_member_id
FROM members
WHERE kakao_platform_id = p_kakao_platform_id;

RETURN v_member_id;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
            return NULL;
WHEN OTHERS THEN
            RAISE;
END;
/
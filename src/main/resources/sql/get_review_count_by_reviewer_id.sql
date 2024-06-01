CREATE OR REPLACE PROCEDURE get_review_count_by_reviewer_id (
    p_reviewer_id IN NUMBER,
    p_review_count OUT NUMBER
) AS
    CURSOR review_cursor (v_reviewer_id NUMBER) IS
        SELECT review_id
        FROM reviews
        WHERE reviewer_id = v_reviewer_id;
    review_id reviews.review_id%TYPE;
BEGIN
    p_review_count := 0;

    OPEN review_cursor(p_reviewer_id);
    LOOP
        FETCH review_cursor INTO review_id;
        EXIT WHEN review_cursor%NOTFOUND;
        p_review_count := p_review_count + 1;
    END LOOP;
    CLOSE review_cursor;
END;
/
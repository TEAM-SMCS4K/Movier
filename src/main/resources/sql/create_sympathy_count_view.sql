CREATE VIEW sympathy_count_view AS
    SELECT p_review_id, COUNT(*) AS sympathy_count
    FROM sympathy
    GROUP BY p_review_id;
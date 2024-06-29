CREATE VIEW sympathy_count_view AS
    SELECT s_review_id, COUNT(*) AS sympathy_count
    FROM sympathy
    GROUP BY s_review_id;
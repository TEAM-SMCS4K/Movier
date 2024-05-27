CREATE VIEW sympathy_count_view AS
    SELECT review_id, COUNT(*) AS sympathy_count
    FROM sympathy
    GROUP BY review_id;
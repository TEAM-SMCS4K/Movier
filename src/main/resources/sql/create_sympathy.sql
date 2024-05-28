CREATE TABLE SYMPATHY (
                          p_member_id NUMBER,
                          p_review_id NUMBER,
                          CONSTRAINT fk_member FOREIGN KEY (p_member_id) REFERENCES members (member_id),
                          CONSTRAINT fk_review FOREIGN KEY (p_review_id) REFERENCES reviews (review_id)
);
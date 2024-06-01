CREATE TABLE SYMPATHY (
                          p_member_id NUMBER NOT NULL,
                          p_review_id NUMBER NOT NULL,
                          CONSTRAINT pk_sympathy PRIMARY KEY (p_member_id, p_review_id),
                          CONSTRAINT fk_member FOREIGN KEY (p_member_id) REFERENCES members (member_id) ON DELETE CASCADE,
                          CONSTRAINT fk_review FOREIGN KEY (p_review_id) REFERENCES reviews (review_id) ON DELETE CASCADE
);
CREATE TABLE SYMPATHY (
                          s_member_id NUMBER NOT NULL,
                          s_review_id NUMBER NOT NULL,
                          CONSTRAINT pk_sympathy PRIMARY KEY (s_member_id, s_review_id),
                          CONSTRAINT fk_member FOREIGN KEY (s_member_id) REFERENCES members (member_id) ON DELETE CASCADE,
                          CONSTRAINT fk_review FOREIGN KEY (s_review_id) REFERENCES reviews (review_id) ON DELETE CASCADE
);
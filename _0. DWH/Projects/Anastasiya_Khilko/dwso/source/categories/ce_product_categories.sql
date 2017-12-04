drop table ce_product_categories;
CREATE TABLE ce_product_categories (
    category_id      NUMBER(2) PRIMARY KEY,
    category_code    VARCHAR2(30 CHAR),
    category_desc    VARCHAR2(100 CHAR),
    insert_dt   DATE,
    update_dt   DATE
);

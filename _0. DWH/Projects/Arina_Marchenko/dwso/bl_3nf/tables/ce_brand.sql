DROP sequence seq_brand;
CREATE SEQUENCE seq_brand INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
  DROP TABLE ce_brand cascade constraints;
  CREATE TABLE ce_brand
    (
      brand_id   NUMBER(6) NOT NULL,
      brand_name VARCHAR2(200) NOT NULL,
	  update_dt date not null
    );

ALTER TABLE ce_brand ADD CONSTRAINT ce_brand_pk PRIMARY KEY (brand_id);
GRANT SELECT ON ce_brand TO bl_cl;
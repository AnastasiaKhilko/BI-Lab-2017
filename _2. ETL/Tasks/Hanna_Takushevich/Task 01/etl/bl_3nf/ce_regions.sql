CREATE TABLE ce_regions (
    region_id     NUMBER(2) PRIMARY KEY,
    region_name   VARCHAR2(200 CHAR)
);

INSERT INTO ce_regions SELECT
    *
FROM
    cls_regions;
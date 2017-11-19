CREATE TABLE cls_regions (
    region_id     NUMBER(2),
    region_name   VARCHAR2(200 CHAR)
);

INSERT INTO cls_regions SELECT
    *
FROM
    cls_regions;
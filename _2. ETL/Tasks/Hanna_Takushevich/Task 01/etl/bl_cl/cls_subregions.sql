CREATE TABLE cls_subregions (
    subregion_id     NUMBER,
    region_id        NUMBER(2),
    subregion_name   VARCHAR2(200 CHAR)
);

INSERT INTO cls_subregions SELECT
    subregion_id,
    region_subregion_key,
    subregion_name
FROM
    wrk_subregions;
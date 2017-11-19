CREATE TABLE ce_subregions (
    subregion_id     NUMBER PRIMARY KEY,
    region_id        NUMBER(2),
    subregion_name   VARCHAR2(200 CHAR),
    CONSTRAINT fk_subregion_region FOREIGN KEY ( region_id )
        REFERENCES ce_regions ( region_id )
);

INSERT INTO ce_subregions SELECT
    *
FROM
    cls_subregions;
CREATE SEQUENCE subreg_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE wrk_subregions (
    subregion_id            NUMBER,
    region_subregion_key    NUMBER,
    subregion_name          VARCHAR2(200 CHAR),
    subregion_country_key   NUMBER(2)
);

INSERT INTO wrk_subregions (
    subregion_id,
    region_subregion_key,
    subregion_name,
    subregion_country_key
) SELECT
    subreg_seq.NEXTVAL,
    to_number(substr(subregion_id,1,1) ),
    subregion_name,
    subregion_country_key
FROM
    ext_geo_subregions;
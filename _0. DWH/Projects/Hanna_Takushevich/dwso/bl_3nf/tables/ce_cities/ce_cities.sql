--==============================================================
-- Table: t_ce_cities
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ce_cities', Object_Type=>'TABLE');

CREATE TABLE ce_cities (
    city_id number,
    country_id number,
    cc_fips     VARCHAR2(2),
    city_name   VARCHAR2(200),
    CONSTRAINT ce_cities_pk PRIMARY KEY (city_id),
    CONSTRAINT city_country_fk FOREIGN KEY (country_id) REFERENCES ce_countries (country_id)
    
);
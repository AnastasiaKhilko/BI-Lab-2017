execute pckg_drop.DROP_Proc('ce_country','TABLE');
execute pckg_drop.DROP_Proc('country_seq','sequence');
CREATE TABLE ce_country
  (
    country_id_seq NUMBER PRIMARY KEY NOT NULL,
    country_num  NUMBER NOT NULL,
    country_name VARCHAR2 (200 CHAR)NOT NULL,
    region_id NUMBER NOT NULL
  );
CREATE sequence COUNTRY_seq start with 1 increment BY 1 nocache nocycle;


--drop sequence COUNTRY_seq;
ALTER TABLE ce_country ADD CONSTRAINT region_id_FK FOREIGN KEY (region_id) REFERENCES ce_region(region_id_seq);
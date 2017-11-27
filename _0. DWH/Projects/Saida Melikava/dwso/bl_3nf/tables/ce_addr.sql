EXECUTE pckg_drop.drop_proc(object_name=>'ce_addr', object_type=>'table');
CREATE TABLE ce_addr
  (
    addr_id           NUMBER(8) PRIMARY KEY,
    addr_code         NUMBER(8),
    addr_street       VARCHAR2(250 CHAR) NOT NULL,
    addr_number_house VARCHAR2(250 CHAR) NOT NULL ,
    addr_city_id      NUMBER(8) NOT NULL,
    insert_DT         DATE DEFAULT(sysdate) NOT NULL ,
    update_DT         DATE DEFAULT(sysdate) NOT NULL
  );
ALTER TABLE ce_addr ADD CONSTRAINT fk_3nf_ce_addr FOREIGN KEY(addr_city_id) REFERENCES ce_cities(city_id);

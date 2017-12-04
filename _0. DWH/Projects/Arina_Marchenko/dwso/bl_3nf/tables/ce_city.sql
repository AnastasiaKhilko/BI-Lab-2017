drop sequence seq_city;
CREATE SEQUENCE seq_city
INCREMENT BY 1 
START WITH 1 
MINVALUE 1 
NOCYCLE;

drop table ce_city cascade constraints;
Create table ce_city(
city_id number(6) not null,
city_name varchar2(200) not null,
country_id number(6) not null,
update_dt date not null
);

grant select on bl_3nf.seq_city to bl_cl;

GRANT SELECT, insert, delete, update ON ce_city to bl_cl;

ALTER TABLE ce_city ADD CONSTRAINT ce_city_pk PRIMARY KEY (city_id);
ALTER TABLE ce_city ADD CONSTRAINT fk_ce_country FOREIGN KEY (country_id) REFERENCES ce_country(country_id);

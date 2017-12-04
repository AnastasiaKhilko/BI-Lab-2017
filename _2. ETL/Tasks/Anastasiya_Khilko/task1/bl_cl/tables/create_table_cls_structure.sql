--execute pckg_drop.DROP_Proc('TABLE', 'cls_structure');
--drop table cls_structure;
create table cls_structure
          (country_id           NUMBER(10,0),
           county_desc          VARCHAR2(200 CHAR),
           structure_code       NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR)
           );
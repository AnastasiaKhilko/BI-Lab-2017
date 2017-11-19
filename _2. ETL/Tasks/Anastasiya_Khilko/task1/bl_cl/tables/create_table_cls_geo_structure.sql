execute pckg_drop.DROP_Proc('TABLE', 'cls_geo_structure');     
create table cls_geo_structure
          (child_code           NUMBER(10,0),
           parent_code          NUMBER(10,0),
           structure_desc       VARCHAR2(200 CHAR),
           structure_level      VARCHAR2(200 CHAR)
           );
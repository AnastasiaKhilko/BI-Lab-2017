--==============================================================
-- Table: t_cls_dim_airlines
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_dim_airlines', Object_Type=>'TABLE');
CREATE TABLE cls_dim_airlines AS
SELECT * FROM ce_airlines;
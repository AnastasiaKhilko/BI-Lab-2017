--==============================================================
-- Table: t_cls_dim_passengers
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_dim_passengers', Object_Type=>'TABLE');
CREATE TABLE cls_dim_passengers AS
SELECT * FROM ce_passengers;
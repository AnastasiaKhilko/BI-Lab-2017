EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_service_class_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE dim_service_class_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON dim_service_class_seq TO bl_cl;
CREATE PUBLIC SYNONYM dim_service_class_seq FOR bl_dm.dim_service_class_seq;
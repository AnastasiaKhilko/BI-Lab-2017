EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'service_class_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE service_class_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON service_class_seq TO bl_cl;
CREATE PUBLIC SYNONYM service_class_seq FOR bl_3nf.service_class_seq;
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'city_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE city_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON city_seq TO bl_cl;
CREATE PUBLIC SYNONYM city_seq FOR bl_3nf.city_seq;
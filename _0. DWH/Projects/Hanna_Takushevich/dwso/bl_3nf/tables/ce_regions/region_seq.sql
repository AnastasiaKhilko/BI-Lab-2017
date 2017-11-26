EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'region_seq', Object_Type=>'SEQUENCE');

CREATE SEQUENCE region_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

GRANT
SELECT ON region_seq TO bl_cl;

CREATE PUBLIC SYNONYM region_seq FOR bl_3nf.region_seq;
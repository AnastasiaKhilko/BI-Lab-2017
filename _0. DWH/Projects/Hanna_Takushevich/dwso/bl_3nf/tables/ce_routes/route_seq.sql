EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'route_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE route_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON route_seq TO bl_cl;
CREATE PUBLIC SYNONYM route_seq FOR bl_3nf.route_seq;
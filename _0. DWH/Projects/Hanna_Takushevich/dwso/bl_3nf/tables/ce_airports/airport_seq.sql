EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'airport_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE airport_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON airport_seq TO bl_cl;
CREATE PUBLIC SYNONYM airport_seq FOR bl_3nf.airport_seq;
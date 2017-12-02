EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'aircraft_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE aircraft_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON aircraft_seq TO bl_cl;
CREATE PUBLIC SYNONYM aircraft_seq FOR bl_3nf.aircraft_seq;
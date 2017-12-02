EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'flight_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE flight_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON flight_seq TO bl_cl;
CREATE PUBLIC SYNONYM flight_seq FOR bl_3nf.flight_seq;
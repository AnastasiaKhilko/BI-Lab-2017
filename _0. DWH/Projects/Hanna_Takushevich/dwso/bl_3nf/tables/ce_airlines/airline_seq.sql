EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'airline_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE airline_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON airline_seq TO bl_cl;
CREATE PUBLIC SYNONYM airline_seq FOR bl_3nf.airline_seq;
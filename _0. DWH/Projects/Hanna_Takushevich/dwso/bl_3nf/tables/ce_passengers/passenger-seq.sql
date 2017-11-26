EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'passenger_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE passenger_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON passenger_seq TO bl_cl;
CREATE PUBLIC SYNONYM passenger_seq FOR bl_3nf.passenger_seq;
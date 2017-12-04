EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_passenger_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE dim_passenger_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON dim_passenger_seq TO bl_cl;
CREATE PUBLIC SYNONYM dim_passenger_seq FOR bl_dm.dim_passenger_seq;
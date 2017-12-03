EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_airline_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE dim_airline_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON dim_airline_seq TO bl_cl;
CREATE PUBLIC SYNONYM dim_airline_seq FOR bl_dm.dim_airport_seq;
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'subregion_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE subregion_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON subregion_seq TO bl_cl;
CREATE PUBLIC SYNONYM subregion_seq FOR bl_3nf.subregion_seq;
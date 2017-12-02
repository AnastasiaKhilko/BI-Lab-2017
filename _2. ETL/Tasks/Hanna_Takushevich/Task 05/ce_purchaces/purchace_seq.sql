EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'purchace_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE purchace_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON purchace_seq TO bl_cl;
CREATE PUBLIC SYNONYM purchace_seq FOR bl_3nf.purchace_seq;
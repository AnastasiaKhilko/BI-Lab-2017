--==============================================================
-- Table: t_dim_service_classes_scd
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'dim_service_classes_scd', Object_Type=>'TABLE');
CREATE TABLE dim_service_classes_scd( 
  service_class_surr_id number not null,
  service_class_id number not null,
  service_class_code varchar2(10) not null,
  service_class_name varchar2(20),
  seat_letter varchar2(1),
  menu varchar2(50),
  max_luggage number,
  service_class_desc varchar2(100),
  start_dt date,
  end_dt date,
  is_active AS (
    CASE
      WHEN end_dt=to_date('31-DEC-9999')
      THEN 'Y'
      ELSE 'N'
    END),
  insert_dt date default sysdate);
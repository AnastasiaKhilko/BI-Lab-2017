--==============================================================
-- Table: t_cls_service_classes
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_service_classes', Object_Type=>'TABLE');
CREATE TABLE cls_service_classes
  (
    class_name  VARCHAR2(20),
    seat_letter VARCHAR2(1),
    menu        VARCHAR2(50),
    max_luggage NUMBER,
    class_desc  VARCHAR2(100),
    class_code  VARCHAR2(10),
    start_dt    DATE,
    end_dt      DATE,
    insert_dt DATE DEFAULT sysdate,
    is_active AS (
    CASE
      WHEN end_dt=to_date('31-DEC-9999')
      THEN 'Y'
      ELSE 'N'
    END)
  );
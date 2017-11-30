CREATE OR REPLACE PACKAGE BODY pkg_etl_passengers
AS
  /**===============================================*\
  Name...............:   pkg_etl_passengers
  Contents...........:   Load data of passenger entity
  Author.............:   Hanna Takushevich
  Date...............:   25-11-2017
  \*=============================================== */
PROCEDURE load_to_wrk
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table wrk_passengers';
  INSERT INTO wrk_passengers
  SELECT * FROM ext_passengers;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_wrk;
PROCEDURE load_to_cls
IS
BEGIN
  EXECUTE IMMEDIATE 'truncate table cls_passengers';
  INSERT INTO cls_passengers
  select to_number(trim(both '"' from num_pass)), give_name, middle_name, last_name, trim(both '"' from city), country_abbr, email,  trim(both '"' from phone), to_date(substr(birthday, 1, instr(birthday, '/',1,2)+4), 'mm/dd/yyyy') from wrk_passengers
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_cls;

PROCEDURE load_to_3nf
IS
BEGIN
  --EXECUTE IMMEDIATE 'truncate table cls_regions';
  MERGE INTO ce_passengers p USING
  ( SELECT num_pass, give_name, middle_name, last_name, country_abbr, email, phone, birthday, city FROM cls_passengers
  MINUS
  SELECT passenger_code, give_name, middle_name, last_name, country_abbr, email, phone, birthday, city FROM ce_passengers
  ) cls ON ( cls.num_pass = p.passenger_code )
WHEN MATCHED THEN
  UPDATE SET p.give_name = cls.give_name, p.middle_name = cls.middle_name, p.last_name = cls.last_name, p.country_abbr = cls.country_abbr, p.email = cls.email,p.phone = cls.phone, p.update_dt = sysdate, p.city=cls.city WHEN NOT MATCHED THEN
  INSERT
    (
      passenger_id,
      passenger_code,
      give_name,
      middle_name,
      last_name,
      city,
      country_abbr,
      email,
      phone,
      birthday,
      insert_dt,
      update_dt
    )
    VALUES
    (
      passenger_seq.nextval ,
      cls.num_pass,
      cls.give_name,
      cls.middle_name,
      cls.last_name,
      cls.city,
      cls.country_abbr,
      cls.email,
      cls.phone,
      cls.birthday,
      sysdate,
      sysdate
    );
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END load_to_3nf;
END pkg_etl_passengers;
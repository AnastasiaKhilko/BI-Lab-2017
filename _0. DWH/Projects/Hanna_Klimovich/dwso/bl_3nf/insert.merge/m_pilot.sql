MERGE INTO bl_3nf.ce_pilot CEP USING
(SELECT pilot_id ,
  national_id ,
  p_name ,
  surname ,
  gender ,
  age ,
  hours_in_air
FROM bl_cl.CL_pilot
MINUS
SELECT pilot_id ,
  national_id ,
  p_name ,
  surname ,
  gender ,
  age ,
  hours_in_air
FROM bl_3nf.ce_pilot
) CLSC ON (CLSC.pilot_ID = CEP.pilot_ID)
WHEN MATCHED THEN
  UPDATE SET CEP.p_name = CLSC.p_name WHEN NOT MATCHED THEN
  INSERT
    (
      pilot_id_seq,
      pilot_id ,
      national_id ,
      p_name ,
      surname ,
      gender ,
      age ,
      hours_in_air
    )
    VALUES
    (
      bl_3nf.pilot_SEQ.NEXTVAL,
      CLSC.pilot_id ,
      CLSC.national_id ,
      CLSC.p_name ,
      CLSC.surname ,
      CLSC.gender ,
      CLSC.age ,
      CLSC.hours_in_air
    );
    COMMIT;
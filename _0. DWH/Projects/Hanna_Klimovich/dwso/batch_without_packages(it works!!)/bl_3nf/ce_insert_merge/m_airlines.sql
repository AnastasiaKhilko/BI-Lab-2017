MERGE INTO bl_3nf.ce_airlines CEAIR USING
(SELECT  Airline_ID ,
      a_name ,
      ICAO ,
      Active
FROM bl_cl.CL_airlines
MINUS
SELECT  Airline_ID ,
      a_name ,
      ICAO ,
      is_Active
FROM bl_3nf.ce_airlines
) CLAIR ON (CLAIR.airline_ID = CEAIR.airline_ID)
WHEN MATCHED THEN
  UPDATE SET CEAIR.a_name = CLAIR.a_name WHEN NOT MATCHED THEN
  INSERT
    (
      airlines_id_seq,
      Airline_ID ,
      a_name ,
      ICAO ,
      is_Active
    )
    VALUES
    (
      bl_3nf.airlines_SEQ.NEXTVAL,
      CLAIR.Airline_ID ,
      CLAIR.a_name ,
      CLAIR.ICAO ,
      CLAIR.Active
    );
  COMMIT;
  
  
  
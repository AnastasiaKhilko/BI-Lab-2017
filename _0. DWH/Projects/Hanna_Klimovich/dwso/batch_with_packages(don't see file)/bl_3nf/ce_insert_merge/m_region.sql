MERGE INTO bl_3nf.ce_region CEP USING
(SELECT region_num , region_name
 FROM bl_cl.CL_region
MINUS
SELECT region_num , region_name FROM bl_3nf.ce_region ) CLSC ON (CLSC.region_num = CEP.region_num)
WHEN MATCHED THEN
  UPDATE SET CEP.region_name = CLSC.region_name WHEN NOT MATCHED THEN
  INSERT
    (
      region_id_seq ,
      region_num ,
      region_name
    )
    VALUES
    (
      bl_3nf.region_seq.NEXTVAL,
      CLSC.region_num ,
      CLSC.region_name
    );
  COMMIT;
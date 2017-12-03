MERGE INTO bl_3nf.ce_plane CEP USING
(SELECT model_name ,
    manufacturer ,
    long_name  ,
    short_name ,
    begin_date ,
    end_date   
FROM bl_cl.CL_PLANE
MINUS
SELECT model_name ,
    manufacturer ,
    long_name  ,
    short_name ,
    begin_date ,
    end_date  
FROM bl_3nf.ce_plane
) CLSC ON (CLSC.model_name = CEP.model_name)
WHEN MATCHED THEN
  UPDATE SET CEP.long_name = CLSC.long_name WHEN NOT MATCHED THEN
  INSERT
    (
      plane_id_seq,
      model_name ,
    manufacturer ,
    long_name  ,
    short_name ,
    begin_date ,
    end_date  
    )
    VALUES
    (
      bl_3nf.plane_SEQ.NEXTVAL,
      CLSC.model_name ,
    CLSC.manufacturer ,
    CLSC.long_name  ,
    CLSC.short_name ,
    CLSC.begin_date ,
    CLSC.end_date  
    );
    COMMIT;
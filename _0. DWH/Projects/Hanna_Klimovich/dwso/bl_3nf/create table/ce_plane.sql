CREATE TABLE ce_plane
  (
    plane_id_seq NUMBER PRIMARY KEY NOT NULL,
    model_name VARCHAR2 (200 CHAR) NOT NULL,
    manufacturer VARCHAR2 (200 CHAR)NOT NULL,
    long_name  VARCHAR2 (200 CHAR),
    short_name VARCHAR2 (200 CHAR),
    begin_date VARCHAR2 (200 CHAR),
    end_date   VARCHAR2 (200 CHAR)
  );
CREATE sequence plane_seq start with 1 increment BY 1 nocache nocycle;
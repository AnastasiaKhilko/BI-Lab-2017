CREATE TABLE ce_pilot
  (
    pilot_id_seq NUMBER PRIMARY KEY NOT NULL,
    pilot_id     NUMBER NOT NULL,
    national_id  VARCHAR2 (200 CHAR),
    p_name       VARCHAR2(200 CHAR),
    surname      VARCHAR2(200 CHAR),
    gender       VARCHAR2(200 CHAR),
    age          NUMBER,
    hours_in_air NUMBER
  );
CREATE sequence pilot_seq start with 1 increment BY 1 nocache nocycle; 
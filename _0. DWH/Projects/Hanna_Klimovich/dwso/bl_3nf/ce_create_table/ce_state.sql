CREATE TABLE ce_state
  (
    state_id_seq NUMBER PRIMARY KEY NOT NULL,
    state_num  NUMBER NOT NULL,
    DEST_STATE_NM VARCHAR2 (200 CHAR)  NOT NULL,
    country_num NUMBER NOT NULL
  );
CREATE sequence state_seq start with 1 increment BY 1 nocache nocycle;

--DROP TABLE CE_state;
--drop sequence state_seq;
ALTER TABLE ce_state ADD CONSTRAINT country_id_FK FOREIGN KEY (country_num) REFERENCES ce_country(country_id_seq);
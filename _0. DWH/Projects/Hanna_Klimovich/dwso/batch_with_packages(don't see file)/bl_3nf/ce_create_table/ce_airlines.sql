execute pckg_drop.DROP_Proc('ce_airlines','TABLE');
execute pckg_drop.DROP_Proc('airlines_seq','sequence');
CREATE TABLE ce_airlines
  (
    airlines_id_seq NUMBER NOT NULL,
    Airline_ID  NUMBER NOT NULL,
    a_name       VARCHAR2 ( 200 CHAR )NOT NULL,                             
    ICAO       VARCHAR2 ( 10 CHAR )PRIMARY KEY ,
    is_Active     VARCHAR2 ( 10 CHAR )
  ); 
CREATE sequence airlines_seq start with 1 increment BY 1 nocache nocycle;


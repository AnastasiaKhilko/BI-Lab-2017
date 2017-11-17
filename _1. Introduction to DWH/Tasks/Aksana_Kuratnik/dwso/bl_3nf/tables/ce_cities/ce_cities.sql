  CREATE TABLE cities
  (
    city_id NUMBER(8) PRIMARY KEY,
    city_name    VARCHAR2(60) NOT NULL,
    state_id  NUMBER(8) NOT NULL,
    CONSTRAINT fk_city_state FOREIGN KEY (state_id) REFERENCES states(state_id)
  );
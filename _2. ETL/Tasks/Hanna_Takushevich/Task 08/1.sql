CREATE OR REPLACE PACKAGE tab_pkg
IS
type rowAirlines
IS
  record
  (
    airline_name cls_airlines.airline_name%TYPE,
    icao_codes cls_airlines.icao_codes%TYPE,
    iata_codes cls_airlines.iata_codes%TYPE,
    airline_country cls_airlines.airline_country%TYPE );
type tblAirlines
IS
  TABLE OF rowAirlines;
  FUNCTION get_cls_airlines
    RETURN tblAirlines pipelined;
END tab_pkg;



CREATE OR REPLACE PACKAGE body tab_pkg
IS
FUNCTION get_cls_airlines
  RETURN tblAirlines pipelined
IS
BEGIN
  FOR curr IN
  (SELECT airline_name,
    SUBSTR(icao_iata_codes, 1, 3),
    SUBSTR(icao_iata_codes, 7, 2),
    airline_country
  FROM wrk_airlines
  WHERE airline_country             IS NOT NULL
  AND SUBSTR(icao_iata_codes, 1, 3) IS NOT NULL
  )
  LOOP
    pipe row (curr);
  END LOOP;
END get_cls_airlines;
END tab_pkg;
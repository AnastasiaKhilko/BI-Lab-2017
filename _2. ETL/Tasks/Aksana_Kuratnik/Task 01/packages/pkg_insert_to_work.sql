CREATE SYNONYM wrk_structure FOR sa_src_lab1.wrk_structure;
CREATE SYNONYM wrk_connection FOR sa_src_lab1.wrk_connection;
CREATE SYNONYM wrk_countries FOR sa_src_lab1.wrk_countries;
  INSERT
  INTO
    cls_continents
  SELECT
    child_code,
    structure_desc
  FROM
    wrk_structure
  WHERE
    parent_code = 1;
  INSERT
  INTO
    cls_regions
  SELECT
    child_code,
    structure_desc,
    parent_code
  FROM
    wrk_structure
  WHERE
    structure_level = 'Regions';
INSERT INTO cls_countries
  SELECT DISTINCT
      cou.country_id,
      county_desc,
      country_code,
      structure_code
  FROM
      wrk_countries cou
      RIGHT JOIN wrk_connection con
      ON cou.country_id = con.country_id;
  COMMIT;
DROP TABLE cl_country;
CREATE TABLE cl_country
  ( country_name VARCHAR2(200) NOT NULL
  );
GRANT SELECT ON cl_country TO bl_3nf;
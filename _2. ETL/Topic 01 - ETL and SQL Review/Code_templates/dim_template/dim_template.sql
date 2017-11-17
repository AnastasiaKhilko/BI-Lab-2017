/**===============================================*\
Name...............:   dim_template
Contents...........:   Dimension description
Author.............:   Author name
Date...............:   Date of last update
\*=============================================== */
DROP TABLE dim_template;
CREATE TABLE dim_template
  (
    dim_surr_id     NUMBER(38) NOT NULL PRIMARY KEY
  , dim_id          NUMBER(38) NOT NULL
  , dim_code        VARCHAR2(30)
  , dim_description VARCHAR2(100)
  );

COMMENT ON TABLE dim_template
IS
  'Table Content: Describe content of a table.
   Refresh Cycle/Window: How often data is loaded and for which period?
  ';

COMMENT ON column dim_template.dim_surr_id     IS 'Dimension surrogate key';
COMMENT ON column dim_template.dim_id          IS 'Dimension business key, comes from some_scheme.t_table_name';
COMMENT ON column dim_template.dim_code        IS 'Dimension business code, comes from some_scheme.t_table_name';
COMMENT ON column dim_template.dim_description IS 'Dimension business description, comes from some_scheme.t_table_name';

GRANT SELECT ON dim_template TO some_user;
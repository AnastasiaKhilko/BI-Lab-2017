/**===============================================*\
Name...............:   fct_template
Contents...........:   Fact table description
Author.............:   Author name
Date...............:   Date of last update
\*=============================================== */
DROP TABLE fct_template;
CREATE TABLE fct_template
  (
    dim1_id             NUMBER(38) NOT NULL
  , dim2_id             NUMBER(38) NOT NULL
  , dim3_id             NUMBER(38) NOT NULL
  , fct_count_smth      NUMBER
  , fct_count_smth_else NUMBER
  , CONSTRAINT fk_dim1 FOREIGN KEY (dim1_id) REFERENCES dim_some_dim(dim_surr_id)
  );

COMMENT ON TABLE fct_template
IS
  'Table Content: Describe content of a table.
   Refresh Cycle/Window: How often data is loaded and for which period?
  ';

COMMENT ON column fct_template.dim1_id             IS 'Foreign key to DIM1. Some description';
COMMENT ON column fct_template.dim2_id             IS 'Foreign key to DIM2. Some description';
COMMENT ON column fct_template.dim3_id             IS 'Foreign key to DIM3. Some description';
COMMENT ON column fct_template.fct_count_smth      IS 'Fact: Number of something counted';
COMMENT ON column fct_template.fct_count_smth_else IS 'Fact: Number of something else counted';

GRANT SELECT ON fct_template TO some_user;
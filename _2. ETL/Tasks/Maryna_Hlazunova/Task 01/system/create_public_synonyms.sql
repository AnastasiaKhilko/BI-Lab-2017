/**===============================================*\
Name...............:   Public synonyms
Contents...........:   Create public synonyms description
Author.............:   Maryna Hlazunova
Date...............:   19-Nov-2017
\*=============================================== */
DROP PUBLIC SYNONYM src_structure;

DROP PUBLIC SYNONYM src_countries;

DROP PUBLIC SYNONYM src_countries_reg;
--

DROP PUBLIC SYNONYM cls_structure;

DROP PUBLIC SYNONYM cls_countries;

DROP PUBLIC SYNONYM cls_countries_reg;
--\*=============================================== */

-- for SA_SRC tables

CREATE PUBLIC SYNONYM src_structure FOR sa_src_test.ext_geo_structure_iso3166;

CREATE PUBLIC SYNONYM src_countries FOR sa_src_test.ext_geo_countries_iso3166;

CREATE PUBLIC SYNONYM src_countries_reg FOR sa_src_test.ext_cntr2structure_iso3166;

-- for CLS tables

CREATE PUBLIC SYNONYM cls_structure FOR bl_cl_test.cls_geo_structure;

CREATE PUBLIC SYNONYM cls_countries FOR bl_cl_test.cls_geo_countries;

CREATE PUBLIC SYNONYM cls_countries_reg FOR bl_cl_test.cls_cnt_structure;
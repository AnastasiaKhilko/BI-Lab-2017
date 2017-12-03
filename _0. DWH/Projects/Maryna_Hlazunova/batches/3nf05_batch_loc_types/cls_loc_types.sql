/**===============================================*\
Name...............:   Cleansing table cls_regions BL_CL layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   24-Nov-2017
\*=============================================== */
DROP TABLE cls_loc_types;
--==============================================================

CREATE TABLE cls_loc_types (
    loc_type_short   VARCHAR2(10 CHAR),
    loc_type_full    VARCHAR2(25 CHAR)
);
--**********************************************

-- SELECT * FROM cls_loc_types;
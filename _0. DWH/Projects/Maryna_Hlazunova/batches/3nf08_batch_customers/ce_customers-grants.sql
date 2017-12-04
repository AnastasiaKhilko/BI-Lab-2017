/**===============================================*\
Name...............:   Grant on table ce_customers
Contents...........:   Create grant description
Author.............:   Maryna Hlazunova
Date...............:   25-Nov-2017
\*=============================================== */
GRANT SELECT ON ce_customers TO bl_cl;

GRANT INSERT ON ce_customers TO bl_cl;

GRANT UPDATE ON ce_customers TO bl_cl;

GRANT SELECT ON ce_customers TO bl_cl_dwh;
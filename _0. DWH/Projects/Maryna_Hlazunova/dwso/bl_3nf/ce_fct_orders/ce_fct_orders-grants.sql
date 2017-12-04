/**===============================================*\
Name...............:   Grant on table ce_deliveries
Contents...........:   Create grant description
Author.............:   Maryna Hlazunova
Date...............:   30-Nov-2017
\*=============================================== */
GRANT SELECT ON ce_fct_orders TO bl_cl;

GRANT INSERT ON ce_fct_orders TO bl_cl;

GRANT UPDATE ON ce_fct_orders TO bl_cl;

GRANT SELECT ON ce_fct_orders TO bl_cl_dwh;
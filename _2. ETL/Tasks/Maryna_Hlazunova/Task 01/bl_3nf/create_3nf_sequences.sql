/**===============================================*\
Name...............:   Sequences 3NF layer
Contents...........:   Create sequences description
Author.............:   Maryna Hlazunova
Date...............:   18-Nov-2017
\*=============================================== */
DROP SEQUENCE seq_worlds;

DROP SEQUENCE seq_continents;

DROP SEQUENCE seq_regions;

DROP SEQUENCE seq_countries;
--\*=============================================== */
CREATE SEQUENCE seq_worlds INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

CREATE SEQUENCE seq_continents INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

CREATE SEQUENCE seq_regions INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/

CREATE SEQUENCE seq_countries INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
/
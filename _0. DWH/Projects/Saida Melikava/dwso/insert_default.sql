INSERT INTO bl_3nf.ce_districts VALUES ('-98','N/A','N/A','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_districts VALUES ('-99','N/D','N/D','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_regions VALUES ('-98','N/A','N/A','-98','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_regions VALUES ('-99','N/D','N/D','-99','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_cities VALUES ('-98','N/A','N/A','-98','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_cities VALUES ('-99','N/D','N/D','-99','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_addr VALUES ('-98','-98','N/A','N/A','-98','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_addr VALUES ('-99','-99','N/D','N/D','-99','01-JAN-1999','01-JAN-1999');

INSERT INTO bl_3nf.ce_genres VALUES ('-98','-98','N/A','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_genres VALUES ('-99','-99','N/D','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_authors VALUES ('-98','-98','N/A','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_authors VALUES ('-99','-99','N/D','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_categories VALUES ('-98','N/A','N/A','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_categories VALUES ('-99','N/A','N/D','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_catalog VALUES ('-98','N/A','-98','N/A','-98','N/A','-98','-98','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_catalog VALUES ('-99','N/D','-99','N/D','-99','N/D','-99','-99','01-JAN-1999','01-JAN-1999');

INSERT INTO bl_3nf.ce_customers VALUES ('-98','N/A','N/A','N/A','N/A','N/A','N/A','-98','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_customers VALUES ('-99','N/D','N/D','N/D','N/D','N/D','N/D','-99','01-JAN-1999','01-JAN-1999');

INSERT INTO bl_3nf.ce_departments VALUES ('-98','-98','N/A','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_departments VALUES ('-99','-99','N/D','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_employees VALUES ('-98','N/A','N/A','N/A','N/A','N/A','-98','-98','-98','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_employees VALUES ('-99','N/D','N/D','N/D','N/D','N/D','-99','-99','-99','01-JAN-1999','01-JAN-1999');

INSERT INTO bl_3nf.ce_stores(store_id,store_code,store_name,store_phone,store_manager_id,store_address_id,start_dt,end_dt, insert_dt) 
VALUES ('-98','N/A','N/A','N/A','-98','-98','01-JAN-1999','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_stores(store_id,store_code,store_name,store_phone,store_manager_id,store_address_id,start_dt,end_dt, insert_dt) 
VALUES ('-99','N/D','N/D','N/D','-99','-99','01-JAN-1999','01-JAN-1999','01-JAN-1999');

INSERT INTO bl_3nf.ce_payments VALUES ('-98','-98','N/A','N/A','N/A','01-JAN-1999','01-JAN-1999');
INSERT INTO bl_3nf.ce_payments VALUES ('-99','-99','N/D','N/D','N/D','01-JAN-1999','01-JAN-1999');

COMMIT;

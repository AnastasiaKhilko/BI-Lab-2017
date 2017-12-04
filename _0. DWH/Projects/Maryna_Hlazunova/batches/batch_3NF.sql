-- ! Execute full_tables start with sys or system

DROP TABLE bl_3nf.ce_fct_items;

DROP TABLE bl_3nf.ce_fct_orders;

DROP TABLE bl_3nf.ce_deliveries;

DROP TABLE bl_3nf.ce_payoptions;

DROP TABLE bl_3nf.ce_customers;

DROP TABLE bl_3nf.ce_pickuppoints;

DROP TABLE bl_3nf.ce_localities;

DROP TABLE bl_3nf.ce_loc_types;

DROP TABLE bl_3nf.ce_districts;

DROP TABLE bl_3nf.ce_regions;

DROP TABLE bl_3nf.ce_products;

DROP TABLE bl_3nf.ce_brands;

DROP TABLE bl_3nf.ce_colors;

DROP TABLE bl_3nf.ce_types;

DROP TABLE bl_3nf.ce_subcategories;

DROP TABLE bl_3nf.ce_categories;

@3nf01_batch_deliveries/full_deliveries.sql

@3nf02_batch_payoptions/full_payoptions.sql

@3nf03_batch_regions/full_regions.sql

@3nf04_batch_districts/full_districts.sql

@3nf05_batch_loc_types/full_loc_types.sql

@3nf06_batch_localities/full_localities.sql

@3nf07_batch_pickuppoints/full_pickuppoints.sql

@3nf08_batch_customers/full_customers.sql

@3nf09_batch_categories/full_categories.sql

@3nf10_batch_subcategories/full_subcategories.sql

@3nf11_batch_types/full_types.sql

@3nf12_batch_brands/full_brands.sql

@3nf13_batch_products/full_products.sql

@3nf14_batch_fct_tables/full_fct_orders_items.sql
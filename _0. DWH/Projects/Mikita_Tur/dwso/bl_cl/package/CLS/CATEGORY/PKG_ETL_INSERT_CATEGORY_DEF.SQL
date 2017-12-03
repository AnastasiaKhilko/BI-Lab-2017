CREATE OR REPLACE PACKAGE  PKG_ETL_INSERT_category 
as 
  procedure INSERT_TABLE_Category;
  procedure merge_TABLE_Category;
  END PKG_ETL_INSERT_Category;
  /
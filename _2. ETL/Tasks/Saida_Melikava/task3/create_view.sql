CREATE VIEW hier AS
SELECT global_id||'G' IDs ,global_desc descs,'' parents FROM globals g
UNION ALL
SELECT continent_id
  ||'C' c,
  continent_desc f ,
  global_id
  ||'G' e
FROM continents cont
UNION ALL
SELECT region_id||'R',region_desc, continent_id||'C' FROM regions reg
UNION ALL
SELECT country_id||'CT', country_desc, region_id||'R' FROM countries countr;

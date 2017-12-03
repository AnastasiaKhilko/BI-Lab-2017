--==============================================================
-- Table: t_cls_dim_airports
--==============================================================
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'cls_dim_airports', Object_Type=>'TABLE');
CREATE TABLE cls_dim_airports AS
SELECT air.airport_id,
  cit.city_id,
  airport_name,
  airport_iata,
  airport_icao,
  airport_faa,
  city_name,
  country_name,
  subregion_name,
  region_name
FROM ce_airports air
JOIN ce_cities cit
ON cit.city_id=air.city_id
JOIN ce_countries con
ON con.country_id=cit.country_id
JOIN ce_subregions sub
ON sub.subregion_id = con.subregion_id
JOIN ce_regions reg
ON sub.region_id = reg.region_id;
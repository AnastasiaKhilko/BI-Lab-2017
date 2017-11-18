select * from ce_regions cr inner join ce_continents cc
on cr.continent_id = cc.continent_id
where cr.region_id = 17
/
select * from ce_countries
/

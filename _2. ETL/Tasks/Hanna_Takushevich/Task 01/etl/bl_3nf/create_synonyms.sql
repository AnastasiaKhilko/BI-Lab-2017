--Создание синонимов для cls таблиц из схемы bl_cl для схемы bl_3nf

BEGIN
	pkg_synonyms.create_syn(schema_name => 'bl_cl', object_name => 'cls_regions', synonym_name => 'cls_regions');
END;
BEGIN
	pkg_synonyms.create_syn(schema_name => 'bl_cl', object_name => 'cls_subregions', synonym_name => 'cls_subregions');
END;
BEGIN
	pkg_synonyms.create_syn(schema_name => 'bl_cl', object_name => 'cls_countries', synonym_name => 'cls_countries');
END;
BEGIN
	pkg_synonyms.create_syn(schema_name => 'bl_cl', object_name => 'cls_cities', synonym_name => 'cls_cities');
END;
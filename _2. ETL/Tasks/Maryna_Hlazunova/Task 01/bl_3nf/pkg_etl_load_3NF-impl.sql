/**===============================================*\
Name...............:   pkg_etl_load_3NF
Contents...........:   Package description
Author.............:   Maryna Hlazunova
Date...............:   18-Nov-2017
\*=============================================== */
/****************************************************/
CREATE OR REPLACE PACKAGE BODY pkg_etl_load_3nf AS

    PROCEDURE load_ce_worlds
        IS
    BEGIN
        DELETE FROM ce_worlds WHERE
            world_code NOT IN (
                SELECT
                    child_code
                FROM
                    cls_structure
                WHERE
                    structure_level = 'World'
            );

        MERGE INTO ce_worlds w USING
            ( SELECT
                child_code AS world_code,
                structure_desc AS world_description
            FROM
                cls_structure
            WHERE
                structure_level = 'World'
            MINUS
            SELECT
                world_code,
                world_description
            FROM
                ce_worlds
            )
        cls ON (
            cls.world_code = w.world_code
        ) WHEN MATCHED THEN
            UPDATE
        SET w.world_description = cls.world_description WHEN NOT MATCHED THEN INSERT ( world_id,world_code,world_description ) VALUES ( seq_worlds.NEXTVAL
,cls.world_code,cls.world_description );

        COMMIT;
        dbms_output.put_line('The data in the table CE_WORLDS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_worlds;
  /****************************************************/

    PROCEDURE load_ce_continents
        IS
    BEGIN
        DELETE FROM ce_continents WHERE
            continent_code NOT IN (
                SELECT
                    child_code
                FROM
                    cls_structure
                WHERE
                    structure_level = 'Continents'
            );

        MERGE INTO ce_continents c USING
            ( SELECT
                s.child_code AS continent_code,
                s.structure_desc AS continent_description,
                w.world_id AS world_id
            FROM
                cls_structure s,
                ce_worlds w
            WHERE
                    w.world_code = s.parent_code
                AND
                    s.structure_level = 'Continents'
            MINUS
            SELECT
                continent_code,
                continent_description,
                world_id
            FROM
                ce_continents
            )
        cls ON (
            cls.continent_code = c.continent_code
        ) WHEN MATCHED THEN
            UPDATE
        SET c.continent_description = cls.continent_description WHEN NOT MATCHED THEN INSERT ( continent_id,continent_code,continent_description,world_id
) VALUES ( seq_continents.NEXTVAL,cls.continent_code,cls.continent_description,cls.world_id );

        COMMIT;
        dbms_output.put_line('The data in the table CE_CONTINENTS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_continents;
/****************************************************/

    PROCEDURE load_ce_regions
        IS
    BEGIN
        DELETE FROM ce_regions WHERE
            region_code NOT IN (
                SELECT
                    child_code
                FROM
                    cls_structure
                WHERE
                    structure_level = 'Regions'
            );

        MERGE INTO ce_regions r USING
            ( SELECT
                s.child_code AS region_code,
                s.structure_desc AS region_description,
                c.continent_id AS continent_id
            FROM
                cls_structure s,
                ce_continents c
            WHERE
                    c.continent_code = s.parent_code
                AND
                    s.structure_level = 'Regions'
            MINUS
            SELECT
                region_code,
                region_description,
                continent_id
            FROM
                ce_regions
            )
        cls ON (
            cls.region_code = r.region_code
        ) WHEN MATCHED THEN
            UPDATE
        SET r.region_description = cls.region_description WHEN NOT MATCHED THEN INSERT ( region_id,region_code,region_description,continent_id ) VALUES
( seq_regions.NEXTVAL,cls.region_code,cls.region_description,cls.continent_id );

        COMMIT;
        dbms_output.put_line('The data in the table CE_REGIONS is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_regions;

/****************************************************/

    PROCEDURE load_ce_countries
        IS
    BEGIN
        DELETE FROM ce_countries WHERE
            country_code NOT IN (
                SELECT
                    country_id
                FROM
                    cls_countries
            );

        MERGE INTO ce_countries cn USING
            ( SELECT
                c.country_id AS country_code,
                c.country_desc AS country_description,
                c.country_code AS country_code_iso,
                r.region_id AS region_id
            FROM
                cls_countries c,
                cls_countries_reg s,
                ce_regions r
            WHERE
                    c.country_id = s.country_id
                AND
                    s.structure_code = r.region_code
            MINUS
            SELECT
                country_code,
                country_description,
                country_code_iso,
                region_id
            FROM
                ce_countries
            )
        cls ON (
            cls.country_code = cn.country_code
        ) WHEN MATCHED THEN
            UPDATE
        SET cn.country_description = cls.country_description,
            cn.country_code_iso = cls.country_code_iso
        WHEN NOT MATCHED THEN INSERT ( country_id,country_code,country_description,country_code_iso,region_id ) VALUES ( seq_countries.NEXTVAL,cls.
country_code,cls.country_description,cls.country_code_iso,cls.region_id );

        COMMIT;
        dbms_output.put_line('The data in the table CE_COUNTRIES is loaded successfully!');
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END load_ce_countries;
/****************************************************/

END pkg_etl_load_3nf;
/
SELECT nf.customer_code, nf.last_name, nf.first_name, nf.middle_name,
        nf.birthdate, nf.gender, nf.personal_discount, nf.cust_loc_id,
        nf.locality_address, nf.start_dt, wrk.start_dt | sysdate, 'N'
        FROM bl_3nf.ce_customers nf,
        wrk_customers2 wrk
        WHERE nf.customer_code=wrk.customer_code 
       and (nf.last_name<>nf.last_name or
        nf.first_name<>nf.first_name or
        nf.middle_name<>nf.middle_name or
        nf.birthdate<>nf.birthdate or
        nf.gender<>nf.gender or
        nf.personal_discount<>nf.personal_discount or
        nf.cust_loc_id<>nf.cust_loc_id or
        nf.locality_address<>nf.locality_address)
        AND TRUNC(sysdate)>=nf.start_dt
        AND TRUNC(sysdate)<nf.end_dt
        UNION ALL
        SELECT wrk.customer_code, wrk.last_name, wrk.first_name, wrk.middle_name, wrk.birthdate, wrk.gender,
        wrk.personal_discount, L.loc_id as cast_loc_id, wrk.locality_address, TRUNC(sysdate) as start_dt,
        TO_DATE('31.12.2999', 'DD.MM.YYYY') as end_dt, 'Y' as is_active
        FROM wrk_customers2 wrk left join bl_3nf.ce_localities L 
        on L.location_name=wrk.locality_desc
        left join bl_3nf.ce_customers nf on (bk=bk
        and TRUNC(sysdate)>=nf.start_dt
        AND TRUNC(sysdate)<nf.end_dt
        and "all attributes are not equal")
        ;
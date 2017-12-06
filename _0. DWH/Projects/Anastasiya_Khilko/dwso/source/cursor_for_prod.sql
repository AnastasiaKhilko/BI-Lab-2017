cursor c_prod is
    select 
        d.product_id as product_id,
        nvl(d.product, 'N/A') as product_desc,
        p.subcategory_id as subcategory_srcid,
        nvl(p.subcategory_desc, 'N/A') as subcategory_desc
    from
        bl_3nf.ce_products d
        left join bl_3nf.ce_product_subcategories p;
    type fetch_array is
        table of c_prod%rowtype;
    prod_sub fetch_array;
begin
    execute immediate 'truncate table cls_products';
    open c_prod;
    loop
        fetch c_prod bulk collect into prod_sub;
        forall i IN 1..prod_sub.count
            insert into cls_products values prod_sub(i);
            
    exit when c_prod%notfound;
end loop;

close c_prod;
commit;
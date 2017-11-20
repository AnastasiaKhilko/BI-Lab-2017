SELECT 
(
  CASE
    WHEN grouping (curr.RUS_DESCRIPTION)=1
    AND grouping (pt.PT_DESCRIPTION)        =0
    THEN 'По всем валютам: '
    WHEN grouping (curr.RUS_DESCRIPTION)=1
    AND grouping (pt.PT_DESCRIPTION)        =1
    THEN 'Итого:'
    ELSE curr.RUS_DESCRIPTION
  END) AS "Итог/Валюта",
  (
  CASE
    WHEN grouping (curr.RUS_DESCRIPTION)=0
    AND grouping (pt.PT_DESCRIPTION)        =1
    THEN ' '
    WHEN grouping (curr.RUS_DESCRIPTION)=1
    AND grouping (pt.PT_DESCRIPTION)        =1
    THEN ' '
    ELSE pt.PT_DESCRIPTION
  END) AS "Тип оплаты",
  SUM(price) as "Продажи"
FROM CL_PAYMENT p JOIN DIMDATETABLE d
ON trunc(p.payment_date)=trunc(d.date_id)
JOIN BL_3NF2.CURRENCY curr
ON p.id_currency=curr.id_currency
JOIN BL_3NF2.PAYMENT_TYPE pt
ON p.id_PAYMENT_TYPE=pt.id_PAYMENT_TYPE
--WHERE p.PAYMENT_DATE>=:p1 and p.PAYMENT_DATE<=:p2
GROUP BY cube (curr.RUS_DESCRIPTION, pt.PT_DESCRIPTION) ;

select * from BL_3NF2.PAYMENT_TYPE;
select * from BL_3NF2.CURRENCY;
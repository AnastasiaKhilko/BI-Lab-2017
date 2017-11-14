with CTE as (select
     SUBSTR(afrom.ALOCATION,INSTR(afrom.ALOCATION, ',', -1)+2) countryFrom ,
     SUBSTR(ato.ALOCATION,INSTR(ato.ALOCATION, ',', -1)+2) countryTo,
      p.PASCOUNTY pasCountry, p.passurname, p.PASNAME, t.TICKET_PRICE price
FROM
    passenger p left join TICKETS t on t.PASID = p.PASID
    left join flight f on f.FCODE=t.FCODE
    left join AIRPORT afrom on f.AIRPORTFROM=afrom.IATA_CODE
    left join AIRPORT ato on f.AIRPORTTO=ato.IATA_CODE
where  p.PASCOUNTY in ('Slovakia','Ukraine')) 

SELECT  case when pasCountry is null then 'TOTAL'
        when grouping_id(pasCountry, countryFrom)= 1 then pasCountry||' ' || 'SUBTOTAL'
        else pasCountry end pasCountry,
        nvl(DECODE(grouping_id(pasCountry, countryFrom), 1, ' ', countryFrom), ' ') AS country_From,
        nvl(SUM(Spain),0) as Spain, nvl(SUM(Germany),0) as Germany, nvl(SUM(Spain),0)+nvl(SUM(Germany),0) AS BOTH_COUNTRIES_SUM
FROM (
SELECT pasCountry, countryFrom, countryTo, price
FROM CTE
WHERE countryTo in ('Spain','Germany') and countryFrom in ('Spain','Germany', 'United Kingdom'))
PIVOT
(SUM(price)
FOR countryTo
IN('Spain' as Spain,'Germany' as Germany))

GROUP BY ROLLUP(pasCountry, countryFrom);
--ORDER BY 1,2

/*
SELECT NVL(pasCountry, 'TOTAL'), --countryFrom,countryTo,
SUM(Spain), SUM(Germany), SUM(Spain)+SUM(Germany) AS Country_SUM
FROM (
SELECT * FROM (
SELECT pasCountry, countryFrom, countryTo, price
FROM CTE
WHERE countryTo in ('Spain','Germany') and countryFrom in ('Spain','Germany', 'United Kingdom'))
PIVOT
(SUM(price)
FOR countryTo
IN('Spain' as Spain,'Germany' as Germany))
ORDER BY 1)
GROUP BY ROLLUP(pasCountry);*/

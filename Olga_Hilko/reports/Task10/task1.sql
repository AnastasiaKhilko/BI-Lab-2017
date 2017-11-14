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
    
SELECT nvl(DECODE(grouping_id(pasCountry), 0, pasCountry, 'GRAND TOTAL'), ' ') AS pas_Country,
       nvl(DECODE(grouping_id(pasCountry, countryFrom), 1, 'TOTAL by countryFrom', countryFrom), ' ') AS country_From,
       nvl(DECODE(grouping_id(pasCountry, countryFrom, countryTo), 1, countryFrom || ' TOTAL(by countryTo)', countryTo), ' ') AS country_To, 
       count(*) times_count, min(price) min_price, max(price) maх_price, sum(price) sum_price
from CTE
WHERE countryTo in ('Spain','Germany') and countryFrom in ('Spain','Germany', 'United Kingdom')
GROUP BY ROLLUP (pasCountry, countryFrom, countryTo)    ;
    --);
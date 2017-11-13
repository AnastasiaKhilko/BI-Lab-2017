CREATE TABLE DimDate as SELECT
	   TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day'),'YYYY')
	  || TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')
	  ||   TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD')  AS Date_Key,
	  TO_DATE('31/12/1999','DD/MM/YYYY')    + NUMTODSINTERVAL(n,'day') AS Full_Date
	  ,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'D')
	  AS Day_Of_Week,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD')
	  AS Day_Of_Month,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DDD')
	  AS Day_Of_Year,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DAY')
	  AS Day_Name,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DY')
	  AS Day_Name_Short,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM')
	  AS Month_Number,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month'
	  ) AS Month_Name,
	  'Q'
	  || TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Q')
	  AS Quarter ,
	  TO_CHAR(TO_DATE('31/12/1999','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY')
	  AS YEAR
	FROM
	  (
	    SELECT
	      level n
	    FROM
	      dual
	      CONNECT BY level <= 7500
	  );
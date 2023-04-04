-- Write a SQL Query to print the sum of all total investment values in 2016(TIV_2016), to a scale of 2 Decimal Places, 
-- for all policy holders who meet the following criteria: 
-- 1) Having the same TIV_2015 value as one or more other policyholders.
-- 2) Are not located in the same city as any other policyholder

CREATE TABLE INVESTMENT 
(
	PID INTEGER,
    TIV_2015 NUMERIC(15,2),
    TIV_2016 NUMERIC(15,2),
    LAT NUMERIC(5,2),
    LONG NUMERIC(5,2)
);
INSERT INTO INVESTMENT VALUES 
(1,10,5,10,10),
(2,20,20,20,20),
(3,10,30,20,20),
(4,10,40,40,40);

SELECT SUM(TIV_2016) AS TIV_2016 
FROM INVESTMENT 
WHERE TIV_2015 IN (SELECT TIV_2015 FROM INVESTMENT GROUP BY 1 HAVING COUNT(*) >1)
AND (LAT , LONG) IN (SELECT LAT , LONG FROM INVESTMENT GROUP BY 1,2 HAVING COUNT(*)=1)
;


--WRITE AN SQL QUERY TO FIND ALL 
-- THE NUMBERS THAT APPEAR ATLEAST THREE TIMES.

CREATE DATABASE LEET_CODE;

USE DATABASE LEET_CODE;

CREATE OR REPLACE TABLE LOG 
( ID INT ,
   NUM VARCHAR(5)
);

INSERT INTO LOG VALUES 
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2);

-- ---------------------------------
SELECT DISTINCT NUM AS CONSECUTIVE_NUMBER FROM (
SELECT 
ID 
,NUM
,LAG(NUM) OVER(ORDER BY ID ASC ) AS LAG_NUM 
,LEAD(NUM) OVER(ORDER BY ID ASC) AS LEAD_NUM
FROM LOG
) 
WHERE NUM = LAG_NUM 
AND NUM = LEAD_NUM;

-- -----------------------------------------------------------
SELECT A.*
FROM LOG A 
JOIN LOG B 
ON A.ID = B.ID+1 AND A.NUM = B.NUM 
JOIN LOG C 
ON A.ID = C.ID +2 AND C.NUM = A.NUM;
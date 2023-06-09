-- Write and SQL Query to display the records with three or more rows with consecutive id's and the number 
-- of people is greater than or equal to 100 for each.Return the result table ordered by visit_date in ascending order. 

--Visit data is the primary key for this table.Each row of this table contains the visit data and visit id 
-- to the stadium with the numner of people during visit. No two rows will have the same visit date, and the id 
--increases, the dates increases as well.

CREATE OR REPLACE TABLE STADIUM 
(
    ID INT, 
    VISIT_DATE DATE,
    PEOPLE INT

);

INSERT INTO STADIUM VALUES 
(1,'2017-01-01' , 10),
(2,'2017-01-02',109),
(3,'2017-01-03',150),
(4,'2017-01-04',99),
(5,'2017-01-05',145),
(6,'2017-01-06',1455),
(7,'2017-01-07',199),
(8,'2017-01-09',188);

SELECT * 
FROM STADIUM;

SELECT 
DISTINCT S1.* 
FROM STADIUM S1 
JOIN STADIUM S2 
JOIN STADIUM S3 
ON (S1.ID = S2.ID-1 AND S1.ID  = S3.ID -2)
OR (S1.ID = S2.ID +1 AND S1.ID = S3.ID -1)
OR (S1.ID = S2.ID +1 AND S1.ID = S3.ID + 2)
WHERE S1.PEOPLE >=100 AND S2.PEOPLE >=100 AND S3.PEOPLE >=100
ORDER BY VISIT_DATE ASC
;


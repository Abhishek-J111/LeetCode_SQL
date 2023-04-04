-- Write a SQL to ge the cumulative sum of an employee salary over a period of 3 months but exclude 
-- the most recent month . The result should be displayed by ID Ascending and then by Month Descending.
CREATE TABLE EMPLOYEE_SALARY
(
	ID INT , 
    MONTH INT , 
    SALARY DOUBLE 
);
INSERT INTO EMPLOYEE_SALARY VALUES 
(1,1,20),
(2,1,20),
(1,2,30),
(2,2,30),
(3,2,40),
(1,3,40),
(3,3,60),
(1,4,60),
(3,4,70);
-- --------------------------------------------------------------------------------------------------
SELECT A.ID ,
A.MONTH ,
SUM(B.SALARY) AS CUMM_SAL
FROM EMPLOYEE_SALARY A 
JOIN EMPLOYEE_SALARY B 
ON A.ID = B.ID 
AND A.MONTH - B.MONTH >= 0 
AND A.MONTH - B.MONTH < 3
GROUP BY 1 , 2
HAVING (A.ID , A.MONTH) NOT IN (SELECT ID , MAX(MONTH) FROM EMPLOYEE_SALARY GROUP BY 1)
ORDER BY 1 ASC , 2 DESC
;

-- -----------------------------------------------------------------------------------------------------
SELECT * FROM EMPLOYEE_SALARY ORDER BY 1,2;
SELECT ID , MONTH , 
SUM(SALARY) OVER(PARTITION BY ID ORDER BY MONTH ASC) as Cummulative_Salary
FROM EMPLOYEE_SALARY 
WHERE (ID,MONTH ) NOT IN (SELECT ID , MAX(MONTH) FROM EMPLOYEE_SALARY GROUP BY 1) 
ORDER BY 1 ASC,2 DESC;
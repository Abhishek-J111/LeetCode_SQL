--1)  WRITE A SQL QUERY TO FIND THE SECOND HIGHEST SALARY FROM THE EMPLOYEE TABLE
CREATE OR REPLACE TABLE EMPLOYEE(
    ID INT ,
    SALARY DOUBLE
);
INSERT INTO EMPLOYEE VALUES
(1,100),
(2,200),
(3,300);

SELECT ID , SALARY FROM (
SELECT * ,
dense_rank() OVER(ORDER BY SALARY DESC) AS SALARY_RNK
FROM EMPLOYEE
) WHERE SALARY_RNK = 2
;
-----------------------------------------------------------------------------------------------
-- 2)  WRITE A SQL QUERY TO RANK SCORES SUCH THAT THERE SHOULD BE NO HOLES BETWEEN RANK
CREATE OR REPLACE TABLE RANK (
    ID INT,
    SCORE DOUBLE
);
INSERT INTO RANK VALUES
(1,3.50),
(2,3.65),
(3,4.00),
(4,3.85),
(5,4.00),
(6,3.65);

SELECT ID ,SCORE ,
dense_rank() OVER(ORDER BY SCORE DESC) AS SCORE_RNK
FROM RANK ;

---------------------------------------------------------------------------------------------------
-- 3) WRITE AN SQL QUERY TO FIND ALL THE NUMBERS THAT APPEARS AT LEAST THREE TIMES CONSECUTIVELY
CREATE TABLE CONSECUTIVE_NUMBER (
    ID INT,
    NUM VARCHAR
);
INSERT INTO CONSECUTIVE_NUMBER VALUES
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2);

SELECT ID , NUM FROM (
SELECT ID , NUM ,
                LAG(NUM) OVER(ORDER BY NUM) AS LAG_NUM,
                LEAD(NUM) OVER(ORDER BY NUM) AS LEAD_NUM
                FROM CONSECUTIVE_NUMBER
)
                WHERE NUM = LAG_NUM AND NUM= LEAD_NUM;
                ;

SELECT T1.ID , T1.NUM
                FROM CONSECUTIVE_NUMBER T1
                INNER JOIN CONSECUTIVE_NUMBER T2 ON
                T1.ID = T2.ID+1 AND T1.NUM = T2.NUM
                INNER JOIN CONSECUTIVE_NUMBER T3 ON
                T1.ID = T3.ID+2 AND T1.NUM = T3.NUM
                ;

-- -------------------------------------------------------------------------------------------
-- 4) Employee Earning more than their managers . Write an SQl query that finds out employee who earns more than their managers.
CREATE TABLE EMPLOYEE2 (
    ID INT ,
    NAME VARCHAR,
    SALARY DOUBLE,
    MANAGERID INT
);
INSERT INTO EMPLOYEE2 values
(1,'Joe',70000,3),
(2,'Henry',80000,4),
(3,'Sam',60000,NULL),
(4,'Max',90000,NULL);

SELECT T1.ID AS EMPLOYEE_ID ,
    T1.NAME AS EMPLOYEE ,
    T1.SALARY AS EMPLOYEE_SALARY,
    T2.NAME AS MANAGER_NAME,
    T2.SALARY AS MANAGER_SALARY
    FROM EMPLOYEE2 T1
    LEFT JOIN EMPLOYEE2 T2
    ON T1.MANAGERID = T2.ID
    WHERE MANAGER_SALARY < EMPLOYEE_SALARY;

-------------------------------------------------------------------------------------------------
-- 5) Write a SQL Query to find the duplicate email in table named Person
CREATE TABLE PERSON
    (
        ID INT,
        EMAIL VARCHAR(10)
    );

INSERT INTO PERSON VALUES
(1 , 'a@b.com'),
(2 , 'c@d.com'),
(3, 'a@b.com');

WITH CTE AS (
SELECT ID , EMAIL ,
        row_number() OVER(PARTITION BY EMAIL ORDER BY ID) AS R_NUM
        FROM PERSON
)
SELECT EMAIL FROM CTE WHERE R_NUM>1;
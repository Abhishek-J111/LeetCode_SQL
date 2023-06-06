--The employee table holds all employee including their managers.Every employee has an ID and there is 
-- also a column for the manager ID . Given the Employee table , Write a SQL query that finds out managers
-- with atleast 5 direct report. 

USE DATABASE DB;
CREATE OR REPLACE TABLE EMPLOYEE 
(
    ID INT , 
    NAME VARCHAR(20), 
    DEPARTMENT VARCHAR(20),
    MANAGERID INT

);

INSERT INTO  EMPLOYEE VALUES 
(101 , 'John' , 'A' , null),
(102,'Dan','A',101),
(103,'James','A',101),
(104,'Amy','A',101),
(105,'Anne','A',101),
(106,'Ron','A',101);

SELECT * FROM EMPLOYEE;

SELECT NAME 
FROM EMPLOYEE WHERE ID = (
SELECT MANAGERID 
FROM EMPLOYEE 
group by 1
HAVING COUNT(*) >=5);


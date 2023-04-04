create or replace table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floors int,
resources varchar(10));

insert into entries values 
('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

WITH CTE AS (
SELECT NAME ,COUNT(FLOORS) AS TOTAL_VISIT 
FROM ENTRIES
GROUP BY NAME
),
CTE2 AS (
SELECT NAME , MAX(MAX_VISITED_FLOOR) AS MAX_VISITED_FLOOR FROM (
SELECT NAME , FLOORS , COUNT(FLOORS) AS MAX_VISITED_FLOOR
FROM ENTRIES
GROUP BY NAME , FLOORS 
)
GROUP BY NAME 
),
CTE3 AS (
    SELECT NAME , listagg(DISTINCT RESOURCES ,',') AS RESOURCES_USED
    FROM ENTRIES
    GROUP BY NAME 
)
SELECT A.NAME , A.TOTAL_VISIT , B.MAX_VISITED_FLOOR ,C.RESOURCES_USED FROM CTE A
JOIN CTE2 B 
ON A.NAME = B.NAME
JOIN CTE3 C 
ON B.NAME = C.NAME
;
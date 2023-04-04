-- Write a SQL Query to find the people who has most friends and the most friends number.

CREATE TABLE SOCIAL_MEDIA 
(
	REQUESTER_ID INT ,
    ACCEPTER_ID INT, 
    ACCEPT_DATE DATE 
);

INSERT INTO SOCIAL_MEDIA VALUES 
(1,2,'2016-06-03'),
(1,3,'2016-06-08'),
(2,3,'2016-06-08'),
(3,4,'2016-06-09');

-- ----------------------------------------------------------------------------------------------------------
WITH CTE AS (
SELECT ID , SUM(FRIEND_COUNT) AS TOTAL_COUNT
FROM (
SELECT REQUESTER_ID AS ID , COUNT(1) AS FRIEND_COUNT
FROM SOCIAL_MEDIA 
GROUP BY REQUESTER_ID
UNION ALL 
SELECT ACCEPTER_ID AS ID, COUNT(1) AS FRIEND_COUNT
FROM SOCIAL_MEDIA 
GROUP BY ACCEPTER_ID
)
GROUP BY 1
)
SELECT * FROM CTE
WHERE TOTAL_COUNT = (SELECT MAX(TOTAL_COUNT) FROM CTE);
;
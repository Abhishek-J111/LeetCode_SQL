-- Write an SQL Query that reports the fraction of players that logged in again on the day after the day they first logged in , rounded to 2 decimal places,
-- Count the number of players that logged in for at least two consecutive days starting from their first login date. 
CREATE TABLE PLAYER_ACTIVITY 
(
	PLAYER_ID INT , 
    DEVIDE_ID INT ,
    EVENT_DATE DATE ,
    GAMES_PLAYED INT
);
INSERT INTO PLAYER_ACTIVITY VALUES
(1,2,'2016-03-01',5),
(1,2,'2016-03-02',6),
(2,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

WITH CTE AS (
SELECT PLAYER_ID , MIN(EVENT_DATE) AS EVENT_DATE
,MIN(dateadd(DAY,1,EVENT_DATE)) AS NEXT_EVENT_DATE
FROM PLAYER_ACTIVITY
GROUP BY PLAYER_ID
)
SELECT ROUND((A_PLAYER/(SELECT COUNT(DISTINCT PLAYER_ID) FROM PLAYER_ACTIVITY)),2) AS FRACTION FROM (
SELECT COUNT(A.PLAYER_ID) AS A_PLAYER
FROM CTE A
JOIN PLAYER_ACTIVITY B 
ON A.PLAYER_ID = B.PLAYER_ID 
AND A.NEXT_EVENT_DATE = DATE(B.EVENT_DATE));
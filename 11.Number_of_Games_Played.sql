-- Write an SQL Query that reports each player and date , how many games played so far by the player,
-- That is, the total number of games played by the player until that date. 
CREATE TABLE ACTIVITY 
(
	PLAYER_ID INT , 
    DEVIDE_ID INT ,
    EVENT_DATE DATE ,
    GAMES_PLAYED INT
);
INSERT INTO ACTIVITY VALUES
(1,2,'2016-03-01',5),
(1,2,'2016-05-02',6),
(1,3,'2017-06-25',1),
(3,1,'2016-03-02',0),
(3,4,'2018-07-03',5);

SELECT PLAYER_ID , EVENT_DATE  
, SUM(GAMES_PLAYED) OVER(PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS GAMES_PLAYED_SO_FAR
FROM ACTIVITY A;

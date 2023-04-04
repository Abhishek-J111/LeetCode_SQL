-- Write a query to find all the consecutive available seats using the cinema table . 
CREATE TABLE CINEMA 
(
	SEAT_ID INT AUTOINCREMENT  ,
    FREE BOOLEAN 
);

INSERT INTO  CINEMA VALUES 
(1,1),
(2,0),
(3,1),
(4,1),
(5,1);
-- -----------------------------------------------------------
SELECT SEAT_ID , FREE FROM (
SELECT SEAT_ID , FREE , 
LAG(FREE) OVER(ORDER BY SEAT_ID ASC) AS LAG_FREE,
LEAD(FREE) OVER(ORDER BY SEAT_ID ASC) AS LEAD_FREE
FROM CINEMA
)WHERE (FREE = LAG_FREE) OR(FREE = LEAD_FREE)
;
-- --------------------------------------------------------------
SELECT a.SEAT_ID , a.FREE
FROM CINEMA A
JOIN CINEMA B on 
ABS(A.SEAT_ID - B.SEAT_ID) = 1
WHERE A.FREE = 1 AND B.FREE = 1
;

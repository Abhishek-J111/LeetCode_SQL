-- Given a Table Tree, ID is the identifier of the tree node and p_id is its parent node's id. Write a query to print the node id 
-- and the type of the node. 

CREATE OR REPLACE TABLE TREE 
(
    ID INT , 
    P_ID INT

);


INSERT INTO TREE VALUES 
(1,NULL),
(2,1),
(3,1),
(4,2),
(5,2);


WITH CTE AS (
SELECT ID , 
P_ID , 
CASE WHEN ID IN (SELECT DISTINCT P_ID FROM TREE) THEN 'Y' ELSE 'N' END AS PARENT_TEST 
FROM TREE
) 
SELECT  
ID , 
CASE WHEN CTE.P_ID IS NULL AND CTE.PARENT_TEST = 'Y' THEN 'ROOT'
     WHEN  CTE.PARENT_TEST = 'N' THEN 'LEAF'
     ELSE 'INNER' END 
FROM CTE;
;
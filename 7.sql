--Write an SQL Query ti find for each seller, wheather the brand of the secon item (by date) 
-- they sold is their favourite brand . If a seller sold less than two items ,
--report the answer for that seller as no .
create table ecomm_users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table ecomm_orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into ecomm_users values 
 (1,'2019-01-01','Lenovo'),
 (2,'2019-02-09','Samsung'),
 (3,'2019-01-19','LG'),
 (4,'2019-05-21','HP');

 insert into items values 
 (1,'Samsung'),
 (2,'Lenovo'),
 (3,'LG'),
 (4,'HP');

 insert into ecomm_orders values 
 (1,'2019-08-01',4,1,2),
 (2,'2019-08-02',2,1,3),
 (3,'2019-08-03',3,2,3),
 (4,'2019-08-04',1,4,2),
 (5,'2019-08-04',1,3,4),
 (6,'2019-08-05',2,2,4);
 
 SELECT * FROM ECOMM_ORDERS;
 
 WITH CTE AS (
 SELECT  SELLER_ID ,ITEM_ID, ORDER_DATE , 
 RANK() OVER(PARTITION BY SELLER_ID ORDER BY ORDER_DATE ASC ) AS RNK 
 FROM ECOMM_ORDERS
 ),
 CTE2 AS (
 SELECT CTE.SELLER_ID , CTE.ITEM_ID AS ITEM_ID1 , CTE.ORDER_DATE , 
 ECOMM_USERS.USER_ID , ECOMM_USERS.favorite_brand , ITEMS.ITEM_ID AS ITEM_ID2
 FROM ECOMM_USERS 
 LEFT JOIN CTE 
 ON CTE.SELLER_ID = ECOMM_USERS.USER_ID AND CTE.RNK =2 
 INNER JOIN ITEMS ON 
 ITEMS.ITEM_BRAND = ECOMM_USERS.favorite_brand 
 )
 SELECT USER_ID , 
    CASE WHEN ITEM_ID1 = ITEM_ID2 THEN 'YES' ELSE 'NO' END AS ND_FAVOURITE_ITEM 
    FROM CTE2 
    ORDER BY USER_ID ASC 
     ;
 ;
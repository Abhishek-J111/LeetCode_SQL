2. Write an SQL query to find the customer count of new and exisitng customer for each order date .
	create table customer_orders (
	order_id integer,
	customer_id integer,
	order_date date,
	order_amount integer
	);
	select * from customer_orders;
	insert into customer_orders values
	(1,100,cast('2022-01-01' as date),2000),
	(2,200,cast('2022-01-01' as date),2500),
	(3,300,cast('2022-01-01' as date),2100)
	,(4,100,cast('2022-01-02' as date),2000),
	(5,400,cast('2022-01-02' as date),2200),
	(6,500,cast('2022-01-02' as date),2700)
	,(7,100,cast('2022-01-03' as date),3000),
	(8,400,cast('2022-01-03' as date),1000),
	(9,600,cast('2022-01-03' as date),3000);
	
-------------------------------------------------------------------------------------------------------------------------------------------------------
WITH CTE AS (
    SELECT ORDER_DATE , COUNT(CUSTOMER_ID) AS TOTAL_CUSTOMER
    FROM CUSTOMER_ORDERS
    GROUP BY ORDER_DATE
),
CTE2 AS (
    SELECT DATE_ORDER , COUNT(CUSTOMER_ID) AS NEW_CUSTOMER  FROM (
    SELECT CUSTOMER_ID , MIN(ORDER_DATE) AS DATE_ORDER
    FROM CUSTOMER_ORDERS
    GROUP BY CUSTOMER_ID
)
    GROUP BY DATE_ORDER
)
SELECT CTE.ORDER_DATE ,  CTE2.NEW_CUSTOMER AS NEW_CUSTOMER , 
(CTE.TOTAL_CUSTOMER - CTE2.NEW_CUSTOMER) AS EXISTING_CUSTOMER
FROM CTE 
JOIN CTE2 
ON CTE.ORDER_DATE = CTE2.DATE_ORDER
;
-------------------------------------------------------------------------------------------------------------------------------------------------------------
with first_visit as (
    SELECT CUSTOMER_ID , MIN(ORDER_DATE) AS ORDER_DATE 
    FROM CUSTOMER_ORDERS 
    GROUP BY CUSTOMER_ID
)  
SELECT CO.ORDER_DATE,
    SUM(CASE WHEN CO.ORDER_DATE = FV.ORDER_DATE THEN 1 ELSE 0 END) AS NEW_CUSTOMER,
    SUM(CASE WHEN CO.ORDER_DATE != FV.ORDER_DATE THEN 1 ELSE 0 END) AS EXISTING_CUSTOMER
FROM CUSTOMER_ORDERS CO
JOIN FIRST_VISIT FV 
ON FV.CUSTOMER_ID = CO.CUSTOMER_ID
GROUP BY CO.ORDER_DATE
;
Create or replace table Trips (id int, 
                     client_id int, 
                     driver_id int, 
                     city_id int, 
                     status varchar(50), 
                     request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6','completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6','completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12','completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12','completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12','cancelled_by_driver', '2013-10-03');

insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');



SELECT REQUEST_AT , 
count(CASE WHEN STATUS IN ('cancelled_by_client','cancelled_by_driver') then 1 else null end) as Cancelled_Trip,
count(1) as total_trips ,
1.0*count(CASE WHEN STATUS IN ('cancelled_by_client','cancelled_by_driver') then 1 else null end)  / count(1)*100 as cancelled_percentage
from (
SELECT * 
FROM TRIPS T 
JOIN USERS C ON 
T.CLIENT_ID = C.USERS_ID 
INNER JOIN USERS D 
ON T.DRIVER_ID = D.USERS_ID
and C.banned = 'No'
)
group by request_at 
;

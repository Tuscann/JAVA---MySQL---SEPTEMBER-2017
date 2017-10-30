---- 1 -----------  01.Table Design

CREATE TABLE towns (
	town_id INT,
	town_name VARCHAR(30) NOT NULL,
	CONSTRAINT pk_towns PRIMARY KEY(town_id)
);

CREATE TABLE airports (
	airport_id INT,
	airport_name VARCHAR(50) NOT NULL,
	town_id INT NOT NULL,
	CONSTRAINT pk_airports PRIMARY KEY(airport_id),
	CONSTRAINT fk_airports_towns FOREIGN KEY(town_id) REFERENCES towns(town_id)
);

CREATE TABLE airlines (
	airline_id INT,
	airline_name VARCHAR(30) NOT NULL,
	nationality VARCHAR(30) NOT NULL,
	rating INT DEFAULT 0,
	CONSTRAINT pk_airlines PRIMARY KEY(airline_id)
);

CREATE TABLE flights (
	flight_id INT AUTO_INCREMENT,
	departure_time DATETIME NOT NULL,
	arrival_time DATETIME NOT NULL,
	status VARCHAR(9) NOT NULL,
	origin_airport_id INT,
	destination_airport_id INT,
	airline_id INT NOT NULL,
	CONSTRAINT pk_flights PRIMARY KEY(flight_id),
	CONSTRAINT fk_flights_airports_origin FOREIGN KEY(origin_airport_id) REFERENCES airports(airport_id),
	CONSTRAINT fk_flights_airports_destination FOREIGN KEY(destination_airport_id) REFERENCES airports(airport_id),
	CONSTRAINT fk_flights_airlines FOREIGN KEY(airline_id) REFERENCES airlines(airline_id)
);

CREATE TABLE customers (
	customer_id INT,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	date_of_birth DATE NOT NULL,
	gender VARCHAR(1) NOT NULL,
	home_town_id INT NOT NULL,
	CONSTRAINT pk_customers PRIMARY KEY(customer_id),
	CONSTRAINT fk_customers_towns FOREIGN KEY(home_town_id) REFERENCES towns(town_id)
);

CREATE TABLE tickets (
	ticket_id INT,
	price DECIMAL(8,2) NOT NULL,
	class VARCHAR(6) NOT NULL,
	seat VARCHAR(5) NOT NULL,
	customer_id INT NOT NULL,
	flight_id INT NOT NULL,
	CONSTRAINT pk_tickets PRIMARY KEY(ticket_id),
	CONSTRAINT fk_tickets_customers FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
	CONSTRAINT fk_tickets_flights FOREIGN KEY(flight_id) REFERENCES flights(flight_id)
);

---- 2 -----------  02.Insert

INSERT INTO flights 
(departure_time, arrival_time,status,origin_airport_id,destination_airport_id,airline_id)
SELECT 
		'2017-06-19 14:00:00',
		'2017-06-21 11:00:00',
 		CASE a.airline_id % 4
		WHEN 0 then 'Departing'
   	WHEN 1 then 'Delayed'
    	WHEN 2 then 'Arrived'
     	WHEN 3 then 'Canceled'
		end,  
		ceiling(sqrt(char_length(a.airline_name))),
		ceiling(sqrt(char_length(a.nationality))),
		a.airline_id
FROM airlines as a
WHERE a.airline_id BETWEEN 1 AND 10;

---- 3 -----------  03.Update Flights

update flights as f
set f.airline_id=1
where status="Arrived";

---- 4 -----------  04.Update Tickets

update tickets as t
inner join flights as f on t.flight_id=f.flight_id
inner join airlines as a on f.airline_id=a.airline_id
set price = price * 1.5
where a.rating=(select max(rating) from airlines);





update tickets as t
inner join flights as f on t.flight_id=f.flight_id
inner join airlines as a on f.airline_id=a.airline_id
set price = price * 1.5
where a.rating=(select rating from airlines order by rating desc limit 1);

---- 5 ----------- 05. Tickets

select t.ticket_id,t.price,t.class,t.seat from tickets as t
order by t.ticket_id asc;

---- 6 ----------- 06. Customers

select c.customer_id,concat(c.first_name,' ',c.last_name)as full_name,c.gender from customers as c
order by full_name asc,c.customer_id;
 
---- 7 ----------- 07. Flights

select f.flight_id,f.departure_time,f.arrival_time from flights as f
where f.`status`="Delayed"
order by f.flight_id asc;

---- 8 ----------- 08. Top 5 Airlines

select distinct a.airline_id,a.airline_name,a.nationality,a.rating from airlines as a
join flights as f
on a.airline_id=f.airline_id
order by a.rating desc,a.airline_id asc
limit 5;

---- 9 ----------- 09. First Class Tickets

select t.ticket_id, a.airport_name as destination,concat(c.first_name,' ',c.last_name ) as customer_name from tickets as t
join flights as f on t.flight_id=f.flight_id
join airports as a on f.destination_airport_id=a.airport_id
join customers as c on t.customer_id=c.customer_id
where t.price<5000 and t.class="First"
order by t.ticket_id asc;

---- 10 ----------- 10. Home Town Customers

select distinct c.customer_id,concat(c.first_name,' ',c.last_name) as full_name,ta.town_name
from customers as c
  join tickets as t on t.customer_id=c.customer_id
  join flights as f on f.flight_id=t.flight_id
  join towns as ta on ta.town_id=c.home_town_id 
  join airports as a on a.airport_id=f.origin_airport_id
where f.`status`='Departing' and a.town_id=c.home_town_id
order by c.customer_id asc;

---- 11 ----------- 11. Flying Customers



---- 12 ----------- 12. Delayed Customers



---- 13 ----------- 13. Last Departing Flights



---- 14 ----------- 14. Flying Children



---- 15 ----------- 15. Airports and Passengers



---- 16 -----------  16.Submit Review



---- 17 ----------- 17. Ticket Purchase



---- 18  ----------- 18. Update Trigger
 



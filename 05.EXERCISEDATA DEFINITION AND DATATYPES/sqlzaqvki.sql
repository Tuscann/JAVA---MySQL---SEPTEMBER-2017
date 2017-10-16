---1------

CREATE DATABASE minions;

---2------

USE  minions;
CREATE TABLE minions
(
   id int PRIMARY KEY
  ,name VARCHAR(50)
  ,age int
);
  
CREATE TABLE towns
(
  id int PRIMARY KEY
, name VARCHAR(50)
);

---3------

ALTER TABLE minions ADD column town_id int;
ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns FOREIGN KEY(town_id)
REFERENCES towns(id);

---4------

INSERT INTO towns(id, name)
VALUES (1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

INSERT INTO minions(id, name, age, town_id)
VALUES (1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

-- -----------------5-------------
Truncate table minions;
-- -----------------6-------------
DROP TABLE minions;
DROP TABLE towns;
-- drop database minions

---7------


---8------


CREATE TABLE users(
	id BIGINT PRIMARY KEY UNIQUE AUTO_INCREMENT,
	username VARCHAR(30) UNIQUE  NOT NULL,
	password  VARCHAR(26) NOT NULL,
	profile_picture  BLOB,
	last_login_time DATE,
	is_deleted BOOL
);


INSERT INTO users(username, password, last_login_time, is_deleted)
VALUES ('Gogo', 'spojpe',  '2017-05-15', TRUE),
('Bobo','epgojro', '2017-08-05', FALSE),
('Ani',  'rpker', '2017-04-25', TRUE),
('Sasho',  'rgpjrpe', '2017-05-06', TRUE),
('Gery', 'pkptkh','2017-01-11', FALSE);


---9------

ALTER TABLE users MODIFY id BigINT NOT NULL;
ALTER TABLE users DROP PRIMARY KEY;
ALTER TABLE users ADD CONSTRAINT pk_users PRIMARY KEY (`id`, `username`);

---10------

alter table users modify column last_login_time NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- ALTER TABLE users MODIFY COLUMN last_login_time TIMESTAMP NOT NULL DEFAULT now();


---11------

ALTER TABLE users MODIFY id BIGINT NOT NULL;
ALTER TABLE users DROP PRIMARY KEY;
ALTER TABLE users ADD CONSTRAINT pk_users PRIMARY KEY(id);
ALTER TABLE users ADD CONSTRAINT uq_username UNIQUE (username);

---12------

create database Movies;
use Movies;

CREATE TABLE directors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    director_name VARCHAR(30) not null,
    notes BLOB
);
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(30) not null,
    notes BLOB
);

CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) not null,
    director_id INT,
    copyright_year DATETIME not null,
    length INT not null,
    genre_id INT not null,
    category_id INT not null,
    rating INT,
    notes BLOB
);

CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(30) not null not null,
    notes BLOB
);

 insert into movies(id,title,director_id,copyright_year,`length`,genre_id,category_id)
 values(11,"kamen",2,'2016-12-12',23,1,2),
(10,"kamen",2,'2016-12-12',23,1,2),
(13,"kamen",2,'2016-12-12',23,1,2),
(14,"kamen",2,'2016-12-12',23,1,2),
(15,"kamen",1,'2016-12-12',23,1,2);

insert into directors(id,director_name,notes)
values(1,'dasdasd','fasdfasdfasdfa'),(2,'dasdasd','fasdfasdfasdfa'),(3,'dasdasd','fasdfasdfasdfa'),(4,'dasdasd','fasdfasdfasdfa'),(5,'dasdasd','fasdfasdfasdfa');

insert into categories(id,category_name)values(1,'wi-fi')
,(2,'wi-fi')
,(3,'wi-fi')
,(4,'wi-fi')
,(5,'wi-fi');

insert into genres(id,genre_name,notes)
values(2,'dasdad','kaman'),(1,'dasdad','kaman'),(3,'dasdad','kaman'),(4,'dasdad','kaman'),(5,'dasdad','kaman');

---13------

create table `categories`(
   id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   category varchar(50) not null,
   daily_rate decimal(5,2),
   weekly_rate decimal(5,2),
   monthly_rate decimal(5,2),
   weekend_rate decimal(5,2)
);
insert into categories(id,category,daily_rate,weekly_rate,monthly_rate,weekend_rate)
values(1,'a',12.23,12.34,12.45,12.45),(2,'dasdads',12.23,12.34,12.45,12.45),(3,'a',12.23,12.34,12.45,12.45);

create table `cars`(
   id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   plate_number int not null,
   make varchar(10) not null,
   model varchar(10),
   car_year datetime,
   category_id int,
   doors INT,
   picture blob,
   car_condition varchar(20),
   available bit
);
insert into `cars`(id,plate_number,make,model,car_year) 
values(1,4,'dasd','dasdasd','1000-01-01 00:00:00'),(2,4,'dasd','dasdasd','1000-01-01 00:00:00'),(3,4,'dasd','dasdasd','1000-01-01 00:00:00');

create table `employees`(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name varchar(50) not null,
    last_name varchar(50),
    title varchar(50),
    notes TEXT
);
insert into `employees`(first_name) values('dasdads'),('dasdads'),('dasdads');

create table`customers`(
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  driver_licence_number varchar(20),
  full_name varchar(50),
  address varchar(50),
  city varchar(50) not null,
  zip_code varchar(50),
  notes TEXT
);
insert into `customers`(city) values('dasdads'),('dasdads'),('dasdads');

create table`rental_orders`(
   id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   employee_id int,
   customer_id int,
   car_id int,
   car_condition varchar(50), 
   tank_level decimal (20,2),
   kilometrage_start int,
   kilometrage_end int,
   total_kilometrage int,
   start_date datetime,
   end_date datetime,
   total_days int,
   rate_applied varchar(50),
   tax_rate int,
   order_status VARCHAR(30),
   notes TEXT
);
insert into `rental_orders`(employee_id,customer_id,car_id) values(1,2,1),(2,2,1),(3,2,1);

---14------

create table employees(
   id INT,
  first_name varchar(50) not null,
  last_name varchar(50),
  title varchar(50),
  notes blob
  ,PRIMARY KEY (id)
);
insert into employees(id,first_name)values(1,'dasd'),(2,'dasd'),(3,'dasd');

create table customers (
   account_number int not null,
   first_name varchar(50) not null, 
	last_name varchar(50),
	phone_number varchar(10),
	emergency_name varchar(50),
	emergency_number varchar(10),
	notes blob,
	primary key(account_number)
);
insert into customers(account_number,first_name)values(1,'dasd'),(2,'dasd'),(3,'dasd');
create table room_status (
   room_status int not null,
   notes blob,
   primary key(room_status)
);
insert into room_status(room_status)values(1),(2),(3);

create table room_types(
   room_type INT not null,
   notes blob not null,
   primary key(room_type)
);
insert into room_types(room_type,notes)values(1,'sasas'),(2,'sasas'),(3,'sasasa');

create table bed_types(
  bed_type INT not null,
  notes blob not null,
  primary key(bed_type)
);
insert into bed_types(bed_type,notes)values(1,'sasas'),(2,'sasas'),(3,'sasasa');

create table rooms(
   room_number int not null, 
   room_type varchar(50),
   bed_type varchar(50),
   rate varchar(50), 
   room_status varchar(50), 
   notes blob not null, 
   primary key(room_number)
);
insert into rooms(room_number,notes)values(1,'sasas'),(2,'sasas'),(3,'sasasa');

create table payments(
   id INT not null,
   employee_id int,
   payment_date datetime, 
   account_number varchar(10), 
   first_date_occupied datetime, 
   last_date_occupied datetime, 
   total_days INT, 
   amount_charged double(10,2), 
   tax_rate double(10,2), 
   tax_amount double(10,2), 
   payment_total double(10,2), 
   notes blob not null, 
   primary key(id)
);
insert into payments(id,notes)values(1,'sasas'),(2,'sasas'),(3,'sasasa');

create table occupancies(
  id int, 
  employee_id int ,
  date_occupied datetime,
  account_number varchar(10),
  room_number int,
  rate_applied varchar(10), 
  phone_charge varchar(10), 
  notes blob not null, 
  primary key(id)
);
insert into occupancies(id,notes)values(1,'sasas'),(2,'sasas'),(3,'sasasa');

---15------
  
  create table towns(
   id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   name varchar(30)
);
create table addresses(
   id  INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   address_text  varchar(50),
   town_id INT,
   CONSTRAINT fk_addresses_towns FOREIGN KEY (town_id)
   REFERENCES towns(id) 
);
create table `departments`(
   id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   name varchar(10)
);
create table employees(
   id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   first_name varchar(10),
   middle_name varchar(10),
   last_name varchar(10),
   job_title varchar(10),
   department_id INT,
   hire_date datetime,
   salary double (10,2),
   address_id INT,
   CONSTRAINT FK_address_id FOREIGN KEY (address_id)
   REFERENCES addresses(id),
   CONSTRAINT FK_department_id FOREIGN KEY (department_id)
   REFERENCES  departments (id)  
);
  
---16------

missing in Judge

---17------

insert into towns(name)values
('Sofia'),('Plovdiv'),('Varna'),('Burgas');

insert into departments(name)values
('Engineering'),('Sales'),('Marketing'),('Software Development'),('Quality Assurance');


insert into employees(first_name,middle_name,last_name,job_title,department_id,hire_date,salary)
values('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01','3500.00'),
('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02','4000.00'),
('Maria','Petrova','Ivanova','Intern',5,'2016-08-28','525.25'),
('Georgi','Terziev','Ivanov','CEO',2,'2007-12-09','3000.00'),
('Peter','Pan','Pan','Intern',3,'2016-08-28','599.88');

---18------

select*from towns;
select*from departments;
select*from employees;

---19------

select*from towns as t order by t.name ;
select*from departments as d order by d.name ;
select*from employees order by salary desc;

---20------

select name from towns order by name;
select name from departments order by name;
select first_name,last_name,job_title,salary from employees order by salary desc;

---21------

update employees
set salary=salary*1.1;
select salary from employees;

---22------

select tax_rate*0.97 from payments;

---23------

delete from occupancies;


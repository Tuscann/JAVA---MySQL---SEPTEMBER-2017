--------1--------

create database test2;
create table persons( person_id int,first_name varchar(50),salary double,passport_id int);
create table passports(passport_id int,passport_number varchar(50));
ALTER TABLE persons ADD PRIMARY KEY(person_id);
ALTER TABLE passports ADD PRIMARY KEY(passport_id);

ALTER TABLE persons ADD CONSTRAINT fk_persons_passports
FOREIGN KEY (passport_id)
REFERENCES passports(passport_id);

insert into passports values(101,'N34FG21B'),(102,'K65LO4R7'),(103,'ZE657QP2');
insert into persons values(1,'Roberto',43300,102),(2,'Tom',56100,103),(3,'Yana',60200,101);

--------2-------

create table manufacturers(manufacturer_id int,name varchar(50),established_on datetime);
create table models(model_id int,name varchar(50),manufacturer_id int);
ALTER TABLE models ADD PRIMARY KEY(model_id);
ALTER TABLE manufacturers ADD PRIMARY KEY(manufacturer_id);
ALTER TABLE models ADD CONSTRAINT 
fk_grade_id FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (manufacturer_id);

-----3-------


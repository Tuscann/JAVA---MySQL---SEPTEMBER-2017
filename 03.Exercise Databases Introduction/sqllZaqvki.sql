﻿---1--

create database minions

---2----

create table minions
 (
 id int primary key,
 name varchar(50),
 age int 
);
create table towns(
id int primary key,
name varchar(50)
)

---3---

ALTER TABLE minions ADD column town_id int;
ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns FOREIGN KEY(town_id)
REFERENCES towns(id);

---4---

insert into minions(id, name, age, town_id) values
(1,'Kevin',22,1),(2,'Bob',15,3),(3,'Steward',NULL,2);
insert into towns (id,name) values
(1,"Sofia"),(2,"Plovdiv"),(3,"Varna")

---5---

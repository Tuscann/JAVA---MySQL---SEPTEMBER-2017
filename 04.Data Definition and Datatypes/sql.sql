
----------2--------------- 
-- use gamebar;
create table categories(
 id int AUTO_INCREMENT primary key,
 name varchar(50) NOT NULL
);
create table products(
 id int AUTO_INCREMENT primary key,
 name varchar(50) NOT NULL,
 category_id int not null
);
create table employees(
id int AUTO_INCREMENT primary key,
first_name varchar(50),
last_name varchar(50)
)  

-----3------------- 

-- use gamebar;
insert into employees(id,first_name,last_name) values(1,"kamen","petrov")
,(2,"kamen","petrov"),(3,"kamen","petrov")

-----4-----------

-- use gamebar;
alter table employees 
add middle_name varchar(50); 

-----5---------

-- use gamebar;
alter table products 
ADD CONSTRAINT fk_category_id
FOREIGN KEY (category_id) references categories(id);

----6-----

-- use gamebar;
alter table employees 
modify column middle_name varchar(100);

----7------
drop database gamebar



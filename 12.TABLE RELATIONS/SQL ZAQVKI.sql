-----1------   Mountains and Peaks

create table mountains(
	id int primary key,
	name varchar(30)
);
create table peaks(
	id int primary key,
	name varchar(30),
	mountain_id int not null,
	constraint fk_mountain_id 
	foreign key(mountain_id) references mountains(id)
);

-----2------   Books and Authors

create table authors(
	id int primary key,
	name varchar(30)
);
create table books(
	id int primary key,
	name varchar(30),
	author_id int not null,
	constraint fk_author_id 
	foreign key(author_id) references authors(id)
	on delete cascade 
);

-----3------   Trip Organization

select driver_id, vehicle_type, concat(first_name, ' ', last_name) as `driver_name`
from vehicles as v
join campers as c
on v.driver_id = c.id;

-----4------   SoftUni Hiking

select starting_point, end_point,leader_id,concat(first_name, " ", last_name) 
from routes as r join campers as c on r.leader_id = c.id;

-----5------   Project Management DB

-- CREATE DATABASE project_db_management;
-- use project_db_management;

create table projects(
	id int primary key auto_increment,
    client_id int,
    project_lead_id int 
);

create table employees(
	id int primary key auto_increment,
    first_name varchar(30),
    last_name varchar(30),
    project_id int
);

alter table projects
add constraint fk_project_lead_id 
foreign key(project_lead_id) references employees(id);

alter table employees
add constraint fk_project_id 
foreign key(project_id) references projects(id);

create table clients(
	id int primary key auto_increment,
    client_name varchar(100),
    project_id int,
    constraint fk_client_project_id
    foreign key(project_id) references projects(id)
);

alter table projects
add constraint fk_client_id 
foreign key(client_id) references clients(id);










create table projects(
	id int primary key auto_increment,
    client_id int,
    project_lead_id int 
);

create table employees(
	id int primary key auto_increment,
    first_name varchar(30),
    last_name varchar(30),
    project_id int
);

alter table projects
add constraint fk_project_lead_id 
foreign key(project_lead_id) references employees(id);

alter table employees
add constraint fk_project_id 
foreign key(project_id) references projects(id);

create table clients(
	id int primary key auto_increment,
    client_name varchar(100),
    project_id int,
    constraint fk_client_project_id
    foreign key(project_id) references projects(id)
);

alter table projects
add constraint fk_client_id 
foreign key(client_id) references clients(id);
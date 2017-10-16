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

-------------------------3-----------------------   Many-To-Many Relationship
create table students(
  student_id INT NOT NULL,
  name varchar(20),
  CONSTRAINT `pk_students` PRIMARY KEY (`student_id`) 
);
create table exams(
  exam_id INT NOT NULL,
  name varchar(20),
  CONSTRAINT `pk_exams` PRIMARY KEY (`exam_id`)
);
create table students_exams(
   student_id INT NOT NULL,
	exam_id INT NOT NULL,
	CONSTRAINT pk_students_exams PRIMARY KEY(student_id,exam_id),
	CONSTRAINT fk_students FOREIGN KEY(student_id) REFERENCES students(student_id),
	CONSTRAINT fk_exam FOREIGN KEY(exam_id) REFERENCES exams(exam_id)	
);
insert into students(name,student_id) values('Mila',1),('Toni',2),('Ron',3);
insert into exams(name,exam_id) values('Spring MVC',101),('Neo4j',102),('Oracle 11g',103);
insert into students_exams(student_id,exam_id) values(1,101),(1,102),(2,101),(3,103),(2,102),(2,103);
---------------4--------  Self-Referencing
-- create database a111;
-- use a111;
create table teachers(
    teacher_id INT not null,
    name varchar(50) NOT NULL,
    manager_id int,
    constraint pk_teacher_id PRIMARY KEY (teacher_id),
    constraint fk_teachers_teachers foreign key (manager_id) references teachers (teacher_id) 
);
insert into teachers value
(101, 'John', NULL), (105, 'Mark', 101), (106, 'Greta', 101), 
(102, 'Maya', 106), (103, 'Silvia', 106), (104, 'Ted', 105);
---------------5-------------  Online Store Database
-- create database a111;
-- use a111;

create table cities (
  city_id int(11),
  name varchar(50),
  CONSTRAINT pk_cities primary key (city_id)
);

create table customers (
  customer_id INT(11),
  name VARCHAR(50),
  birthday DATE,
  city_id INT(11),
  constraint pk_customers primary key (customer_id),
  constraint fk_customers_cities foreign key (city_id) references cities (city_id) 
);

create table orders(
  order_id int(11),  
  customer_id int(11),
  constraint pk_orders primary key(order_id),
  constraint fk_orders_customers foreign key(customer_id) references customers (customer_id) 
);

create table item_types(
   item_type_id int(11),
   name varchar(50),
   constraint pk_item_types primary key (item_type_id)
);

create table items(
  item_id int(11),
  name varchar(50),
  item_type_id int(11),
  CONSTRAINT pk_items primary key (item_id),
  CONSTRAINT fk_items_item_types FOREIGN KEY (item_type_id) REFERENCES item_types(item_type_id)
);

create table order_items(
  order_id int(11),
  item_id int(11),
  constraint pk_order_items primary key (order_id,item_id),
  constraint fk_order_items_orders foreign key(order_id) references orders(order_id),
  constraint fk_order_items_items foreign key(item_id) references items(item_id)
);

------ 6 ------------ University Database
-- create database a111;
-- use a111;

create table majors(
  major_id INT(11),
  name varchar(50),
  constraint pk_majors primary key(major_id)
);
create table students(
  student_id int(11),
  student_number varchar(12),
  student_name varchar(50),
  major_id INT(11),
  constraint pk_students primary key (student_id),
  constraint fk_students_majors foreign key(major_id) references majors(major_id)
);

create table payments(
  payment_id INT(11),
  payment_date DATE,
  payment_amount DECIMAL(8,2),
  student_id INT(11),
  constraint pk_payments primary key (payment_id),
  constraint fk_payments_students foreign key(student_id) references students(student_id)
);

create table subjects(
  subject_id INT(11),
  subject_name varchar(50),
  constraint pk_subjects primary key(subject_id)
);

create table agenda(
   student_id int(11),
   subject_id int(11),
   constraint pk_agenda primary key(student_id,subject_id),
   constraint fk_agenda_subjects foreign key(subject_id) references subjects(subject_id),
   constraint fk_agenda_students foreign key(student_id) references students(student_id)
);

---- 9 ----------- Peaks in Rila

select mountain_range,peak_name,elevation as peak_elevation 
from peaks as p
join mountains as m
on p.mountain_id=m.id
where mountain_range = 'Rila'
order by peak_elevation desc;


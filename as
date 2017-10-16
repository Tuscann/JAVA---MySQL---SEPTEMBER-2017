[1mdiff --git a/13.EXERCISE TABLE RELATIONS/sql zaqvki.sql b/13.EXERCISE TABLE RELATIONS/sql zaqvki.sql[m
[1mindex c6f5722..24eb34d 100644[m
[1m--- a/13.EXERCISE TABLE RELATIONS/sql zaqvki.sql[m	
[1m+++ b/13.EXERCISE TABLE RELATIONS/sql zaqvki.sql[m	
[36m@@ -22,5 +22,135 @@[m [mALTER TABLE manufacturers ADD PRIMARY KEY(manufacturer_id);[m
 ALTER TABLE models ADD CONSTRAINT [m
 fk_grade_id FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (manufacturer_id);[m
 [m
[31m------3-------[m
[32m+[m[32m-------------------------3-----------------------   Many-To-Many Relationship[m
[32m+[m[32mcreate table students([m
[32m+[m[32m  student_id INT NOT NULL,[m
[32m+[m[32m  name varchar(20),[m
[32m+[m[32m  CONSTRAINT `pk_students` PRIMARY KEY (`student_id`)[m[41m [m
[32m+[m[32m);[m
[32m+[m[32mcreate table exams([m
[32m+[m[32m  exam_id INT NOT NULL,[m
[32m+[m[32m  name varchar(20),[m
[32m+[m[32m  CONSTRAINT `pk_exams` PRIMARY KEY (`exam_id`)[m
[32m+[m[32m);[m
[32m+[m[32mcreate table students_exams([m
[32m+[m[32m   student_id INT NOT NULL,[m
[32m+[m	[32mexam_id INT NOT NULL,[m
[32m+[m	[32mCONSTRAINT pk_students_exams PRIMARY KEY(student_id,exam_id),[m
[32m+[m	[32mCONSTRAINT fk_students FOREIGN KEY(student_id) REFERENCES students(student_id),[m
[32m+[m	[32mCONSTRAINT fk_exam FOREIGN KEY(exam_id) REFERENCES exams(exam_id)[m[41m	[m
[32m+[m[32m);[m
[32m+[m[32minsert into students(name,student_id) values('Mila',1),('Toni',2),('Ron',3);[m
[32m+[m[32minsert into exams(name,exam_id) values('Spring MVC',101),('Neo4j',102),('Oracle 11g',103);[m
[32m+[m[32minsert into students_exams(student_id,exam_id) values(1,101),(1,102),(2,101),(3,103),(2,102),(2,103);[m
[32m+[m[32m---------------4--------  Self-Referencing[m
[32m+[m[32m-- create database a111;[m
[32m+[m[32m-- use a111;[m
[32m+[m[32mcreate table teachers([m
[32m+[m[32m    teacher_id INT not null,[m
[32m+[m[32m    name varchar(50) NOT NULL,[m
[32m+[m[32m    manager_id int,[m
[32m+[m[32m    constraint pk_teacher_id PRIMARY KEY (teacher_id),[m
[32m+[m[32m    constraint fk_teachers_teachers foreign key (manager_id) references teachers (teacher_id)[m[41m [m
[32m+[m[32m);[m
[32m+[m[32minsert into teachers value[m
[32m+[m[32m(101, 'John', NULL), (105, 'Mark', 101), (106, 'Greta', 101),[m[41m [m
[32m+[m[32m(102, 'Maya', 106), (103, 'Silvia', 106), (104, 'Ted', 105);[m
[32m+[m[32m---------------5-------------  Online Store Database[m
[32m+[m[32m-- create database a111;[m
[32m+[m[32m-- use a111;[m
[32m+[m
[32m+[m[32mcreate table cities ([m
[32m+[m[32m  city_id int(11),[m
[32m+[m[32m  name varchar(50),[m
[32m+[m[32m  CONSTRAINT pk_cities primary key (city_id)[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32mcreate table customers ([m
[32m+[m[32m  customer_id INT(11),[m
[32m+[m[32m  name VARCHAR(50),[m
[32m+[m[32m  birthday DATE,[m
[32m+[m[32m  city_id INT(11),[m
[32m+[m[32m  constraint pk_customers primary key (customer_id),[m
[32m+[m[32m  constraint fk_customers_cities foreign key (city_id) references cities (city_id)[m[41m [m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32mcreate table orders([m
[32m+[m[32m  order_id int(11),[m[41m  [m
[32m+[m[32m  customer_id int(11),[m
[32m+[m[32m  constraint pk_orders primary key(order_id),[m
[32m+[m[32m  constraint fk_orders_customers foreign key(customer_id) references customers (customer_id)[m[41m [m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32mcreate table item_types([m
[32m+[m[32m   item_type_id int(11),[m
[32m+[m[32m   name varchar(50),[m
[32m+[m[32m   constraint pk_item_types primary key (item_type_id)[m
[32m+[m[32m);[m
[32m+[m
[32m+[m[32mcreate table items([m
[32m+[m[32m  item_id int(11),[m
[32m+[m[32m  name varchar(50),[m
[32m+[m[32m  item_type_id int(11),[m
[32m+[m[32m  CONSTRAINT pk_items primary key (item_id),[m
[32m+[m[32m  CONSTRAINT fk_items_item_types FOREIGN KEY (item_type_id) 
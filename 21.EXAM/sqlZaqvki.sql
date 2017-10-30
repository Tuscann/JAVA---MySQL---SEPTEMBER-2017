create database exam;

--- 1 ---
CREATE TABLE users(

	id INT(11) UNIQUE PRIMARY KEY ,

	username VARCHAR(30) UNIQUE,

	`password` VARCHAR(50) NOT NULL,

	name VARCHAR(50),

	gender VARCHAR(1),

	birthdate DATETIME,

	age INT(11),

	email VARCHAR(50) NOT NULL

);

CREATE TABLE departments(

	id INT(11) UNIQUE  PRIMARY KEY,

	name VARCHAR(50) NOT NULL

);



CREATE TABLE employees (

	id INT(11) UNIQUE PRIMARY KEY AUTO_INCREMENT,

	first_name VARCHAR(25),

	last_name VARCHAR(25),

	gender VARCHAR(1),

	birthdate DATETIME,

	age INT(11),

	department_id INT(11),

	CONSTRAINT fk_employee_dep 

	FOREIGN KEY(department_id)

	REFERENCES departments(id)

);



CREATE TABLE categories (

	id INT(11) UNIQUE  PRIMARY KEY,

	name VARCHAR(50) NOT NULL,

	department_id INT(11),

	CONSTRAINT fk_category_dep

	FOREIGN KEY(department_id)

	REFERENCES departments(id)

);



CREATE TABLE `status` (

	id INT(11) UNIQUE  PRIMARY KEY,

	label VARCHAR(30) NOT NULL

);





CREATE TABLE reports (

	id INT(11) UNIQUE  PRIMARY KEY AUTO_INCREMENT,

	category_id INT(11),

	status_id INT(11),

	open_date DATETIME,

	close_date DATETIME,

	description VARCHAR(200),

	user_id INT(11),

	employee_id INT(11),

	CONSTRAINT fk_report_category

	FOREIGN KEY(category_id) REFERENCES categories(id),

	CONSTRAINT fk_report_status

	FOREIGN KEY(status_id) REFERENCES `status`(id),

	CONSTRAINT fk_report_user

	FOREIGN KEY(user_id) REFERENCES users(id),

	CONSTRAINT fk_report_employee

	FOREIGN KEY(employee_id) REFERENCES employees(id)

);

--- 2 ---

INSERT INTO employees 
(first_name, last_name,gender,birthdate,department_id)
VALUES
('Marlo', 'O\'Malley', 'M', '1958-9-21', 1),
('Niki', 'Stanaghan', 'F', '1969-11-26', 4),
('Ayrton', 'Senna', 'M', '1960-03-21', 9),
('Ronnie', 'Peterson', 'M', '1944-02-14', 9),
('Giovanna', 'Amati', 'F', '1959-07-20', 5);

INSERT INTO reports 
(category_id,status_id,open_date,close_date,description,user_id,employee_id)
VALUES
(1, 1,'2017-04-13', NUll,'Stuck Road on Str.133',6,2),
(6, 3,'2015-09-05', '2015-06-12','Charity trail running',3,5),
(14, 2,'2015-09-07', NULL,'Falling bricks on Str.58',5,2),
(4, 3,'2017-07-03', '2017-07-06','Cut off streetlight on Str.11',1 ,1);

----- 3 -------

update `status` as s
join reports as r on s.id=r.status_id
set r.status_id=2
where (s.id>=1 and s.id<=4);

---- 4 -------

delete from reports
where status_id = 4;

----- 5 -------

select u.username,u.age from users as u
order by u.age asc,u.username desc;

----- 6 -------

select r.description,r.open_date
from reports as r
where r.employee_id IS NULL
order by r.open_date asc,r.description;

---- 7 --------

select e.first_name,e.last_name,r.description,DATE_FORMAT(r.open_date, "%Y-%m-%d")as open_date
from employees as e
join reports as r
on e.id=r.employee_id
order by e.id asc,r.open_date asc,r.id asc;

----8-----------

select c.name,Count(r.id) as reports_number
from categories as c
join reports as r
on r.category_id=c.id
group by c.name
order by reports_number asc,c.name asc

----9-----------

select c.name,Count(e.id) from employees as e
join departments as d on e.department_id=d.id
join categories as c on c.department_id=d.id
group by c.name
order by c.name asc;

---10---------

select distinct c.name as category_name
from categories as c
join reports as r on r.category_id=c.id
join users as u on u.id=r.user_id
where  EXTRACT(MONTH FROM open_date) = EXTRACT(MONTH FROM u.birthdate) 
 and day(open_date) = day(u.birthdate )
group by c.name
order by c.name asc;

-----11--------

SELECT CONCAT(e.first_name,' ',e.last_name) AS 'name',COUNT(r.user_id) AS 'users_count'
	FROM employees AS e
	LEFT OUTER JOIN reports AS r
	ON e.id = r.employee_id
	AND (r.user_id IN (SELECT DISTINCT r.user_id
	FROM reports AS r) OR r.User_Id )
	GROUP BY name
	ORDER BY users_count DESC,`name`;

----- 12 --------

select r.open_date,r.description,u.email as reporter_email 
from reports as r join users as u on u.id=r.user_id
join categories as c on c.id=r.category_id
join departments as d on d.id=c.department_id
where r.close_date is null 
and LENGTH(r.description)>20 
and r.description  like "%str%"
and (d.name='Infrastructure' or d.name='Emergency' or d.name='Roads Maintenance')
order by r.open_date asc,reporter_email asc;

----- 13 --------

select distinct  u.username
from users as u
join reports as r on r.user_id=u.id 
join categories as c on c.id=r.category_id 
where ((SUBSTRING(u.username, 1, 1)>= '0' and SUBSTRING(u.username, 1, 1) < ':' and c.id=SUBSTRING(u.username, 1, 1)) 
OR (SUBSTRING(REVERSE(u.username), 1, 1)>= '0' and SUBSTRING(REVERSE(u.username), 1, 1) < ':' and c.id=SUBSTRING(REVERSE(u.username), 1, 1))) 
order by u.username;

------------ 14 --------  

SELECT fn, CONCAT(cnt_closed, '/', cnt_open) FROM (
		SELECT
		   CONCAT(e.first_name, ' ', e.last_name) as fn,
		   COUNT(
			   CASE 
			      WHEN YEAR(close_date) = 2016 THEN 'closed'
			      WHEN YEAR(open_date) < 2016 AND YEAR(close_date) = 2016 THEN 'closed'
			   END) cnt_closed,
		   COUNT(
				   CASE 
				      WHEN YEAR(open_date) = 2016 THEN 'open'
		   END) AS cnt_open
		   FROM reports r
		   JOIN employees e
		   ON r.employee_id = e.id   
		   GROUP BY fn
		   HAVING cnt_open > 0 OR cnt_closed > 0) w
   order by w.fn

------------ 15 -------- 

SELECT d.Name AS Department_name,
       CASE
           WHEN SUM(TIMESTAMPDIFF(DAY, R.Open_date, R.Close_date)) IS NULL
             THEN 'no info'
		 ELSE floor(CAST(AVG(TIMESTAMPDIFF(DAY, R.Open_date, R.Close_date)) AS char(100)))
       END AS `Myaverage`
FROM Departments AS D
     JOIN Categories AS C ON C.Department_Id = D.Id
     LEFT JOIN Reports AS R ON R.Category_Id= C.Id
GROUP BY D.Name
order by d.name;

------------ 16 -------- 

SELECT d.name, c.name,
FORMAT((SELECT COUNT(*) FROM reports rc WHERE rc.category_id = c.id) / (SELECT COUNT(*) 
    FROM reports rd 
    WHERE rd.category_id IN 
        (SELECT cd.id FROM categories cd 
            JOIN departments dd ON cd.department_id=dd.id WHERE dd.id = d.id))
            * 100, 0) p
 FROM 
departments d
JOIN categories c
ON d.id = c.department_id
JOIN reports r ON r.category_id = c.id
WHERE r.user_id IS NOT NULL
GROUP BY d.name, c.name
ORDER BY d.name, c.name, p

------------ 17 -------- 

CREATE FUNCTION udf_get_reports_count(employee_id INT, status_id INT)
RETURNS INT
BEGIN
	DECLARE reports_count INT;
	SET reports_count := 
		(SELECT COUNT(r.id) FROM reports AS r 
		WHERE r.Employee_Id = employee_id 
		and r.Status_Id = status_id);
	RETURN reports_count;
END

------------ 18 --------  

CREATE PROCEDURE usp_assign_employee_to_report(employee_id INT, report_id INT) 
BEGIN
	DECLARE employee_department_id int;
	DECLARE report_category_id int;
	DECLARE category_department_id int;
	
	set employee_department_id := (SELECT department_id FROM employees AS e WHERE e.id = employee_id);
	set report_category_id := (SELECT category_id FROM reports AS r WHERE r.id = report_id);
	set category_department_id := (SELECT department_id FROM categories as c WHERE c.id = report_category_id);
	
	START TRANSACTION;
		IF(employee_department_id != category_department_id) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee doesn\'t belong to the appropriate department!';
			ROLLBACK;
		ELSE
			UPDATE reports AS r
			SET r.employee_id = employee_id
			WHERE r.id = report_id;
		END IF;
	COMMIT;
END

------------ 19 -------- 

create trigger t_update_close_date
BEFORE UPDATE ON reports 
FOR EACH ROW
BEGIN
	if(old.close_date is null and new.close_date is not null) then
		set new.status_id = 3;
	end if;
end

------------ 20 -------- 

SELECT c.name,
    COUNT(r.id),
    CASE 
        WHEN (SELECT COUNT(*) FROM reports rr WHERE rr.status_id = (SELECT id FROM status WHERE label = 'waiting') AND rr.category_id = c.id) >
        (SELECT COUNT(*) FROM reports rr WHERE rr.status_id = (SELECT id FROM status WHERE label = 'in progress')  AND rr.category_id = c.id)
        THEN 'waiting'
        WHEN (SELECT COUNT(*) FROM reports rr WHERE rr.status_id = (SELECT id FROM status WHERE label = 'waiting')  AND rr.category_id = c.id) <
        (SELECT COUNT(*) FROM reports rr WHERE rr.status_id = (SELECT id FROM status WHERE label = 'in progress')  AND rr.category_id = c.id)
        THEN 'in progress'
        ELSE 'equal'
    END as main_status
FROM categories c
JOIN reports r
ON r.category_id = c.id
JOIN status s
ON r.status_id = s.id
WHERE s.label IN ('waiting', 'in progress')
GROUP BY c.name
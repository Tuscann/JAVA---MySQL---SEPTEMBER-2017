---------1----------------

-- Missing in Judge

---------2----------------

select*from departments as d
order by d.department_id asc;

---------3----------------

select d.name from departments as d
order by d.department_id asc;

---------4----------------

select e.first_name,e.last_name,e.salary from employees as e
order by e.employee_id asc;

---------5----------------

select e.first_name,e.middle_name,e.last_name from employees as e
order by e.employee_id asc;

---------6----------------

select concat(e.first_name,'.',e.last_name,'@gmail.com')as full_email_address from employees as e
order by e.employee_id asc;

---------7----------------

-- SELECT DISTINCT salary FROM employees ORDER BY salary;
select distinct e.salary from employees as e order by e.employee_id asc;

---------8----------------

select*from employees as e
where e.job_title="Sales Representative"
order by e.employee_id;

---------9----------------

select e.first_name,e.last_name,e.job_title from employees as e
where e.salary>=20000 and e.salary<=30000
order by e.employee_id asc;

---------10----------------

select e.first_name,e.last_name from employees as e
where e.manager_id is null;

---------11----------------

select e.first_name,e.last_name,e.salary from employees as e
where e.salary>50000
order by e.salary desc;

---------12----------------

select e.first_name,e.last_name from employees as e

order by e.salary desc
limit 5;

---------13----------------

select e.first_name,e.last_name from employees as e
where e.department_id!=4;

---------14----------------

select*from employees as e
order by e.salary desc,e.first_name,e.last_name desc,e.middle_name asc;

---------15----------------

create view v_employees_salaries as (select e.first_name,e.last_name,e.salary from employees as e);

---------16----------------

update employees as e set e.middle_name=''where e.middle_name is null;  
create view v_employees_job_titles  as (select concat(e.first_name,' ',e.middle_name,' ',e.last_name)as full_name,e.job_title from employees as e);

---------17----------------

select distinct e.job_title from employees as e
order by e.job_title;

---------18----------------

select*from projects as p
order by p.start_date,p.name
limit 10;

---------19----------------

SELECT first_name,last_name,hire_date 
FROM employees
ORDER BY hire_date DESC
LIMIT 7;

---------20----------------

update employees
set salary=salary*1.12
WHERE department_id='1'or department_id='2' or department_id='4' or department_id='11';
SELECT salary FROM employees;

---------21----------------

SELECT peak_name FROM peaks ORDER BY peak_name

---------22----------------

SELECT country_name,population FROM countries 
WHERE continent_code='EU'
ORDER BY population DESC,country_name asc
LIMIT 30

---------23----------------

SELECT country_name,country_code,if(currency_code='EUR','Euro','Not Euro') as currency FROM countries 
ORDER BY country_name ASC;

---------24----------------

select name from characters order by name asc;




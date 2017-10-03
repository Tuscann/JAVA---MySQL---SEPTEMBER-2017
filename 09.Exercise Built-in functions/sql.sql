--------1--------

select e.first_name,e.last_name from employees as e
where e.first_name like 'SA%'
order by e.employee_id;

-------2-----------

select e.first_name,e.last_name 
from employees as e
where e.last_name like '%ei%'
order by e.employee_id

-------3-----------

select e.first_name from employees as e
where (e.department_id=3 or e.employee_id=10) 
and year(e.hire_date)>=1995 and year(e.hire_date)<=2005
order by e.employee_id

-------4-----------

select e.first_name,e.last_name from employees as e
where e.job_title not like '%engineer%'
order by e.employee_id


-------5-----------

select  t.name from towns as t
where Length( t.name)=5 or Length(t.name)=6
order by t.name asc


-------6-----------

select t.town_id, t.name from towns as t
where (t.name like 'b%' or t.name like 'k%' or t.name like 'm%' or t.name like 'e%')
order by t.name asc


-------7-----------

select t.town_id, t.name from towns as t
where (t.name not like 'b%' or t.name like 'r%' or t.name like 'd%')
order by t.name asc


-------8-----------

create view v_employees_hired_after_2000 
as select e.first_name,e.last_name from employees as e
where year(e.hire_date)>2000

--------9----------

select e.first_name,e.last_name from employees as e
where length (e.last_name)=5

-------10-----------

select c.country_name,c.iso_code
 from countries as c
 where lower(length(c.country_name)-length(replace(c.country_name,'a',''))+1)>=3
 order by c.iso_code

--------11----------


-------12-----------



-------13----------



-------14-----------



------15----------

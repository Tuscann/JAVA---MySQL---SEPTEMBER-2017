--------- 1 -------------  Employee Address

select e.employee_id,e.job_title,e.address_id,a.address_text from employees as e
join addresses as a on a.address_id=e.address_id
order by e.address_id asc
limit 5;

--------- 2 -------------  Addresses with Towns

select e.first_name,e.last_name ,t.name as town,a.address_text from employees as e
join addresses as a on a.address_id=e.address_id
join towns as t on t.town_id=a.town_id
order by e.first_name asc,e.last_name
limit 5;

--------- 3 -------------  Sales Employee

select e.employee_id,e.first_name ,e.last_name,d.name as department_name
from employees as e
join departments as d on e.department_id=d.department_id
where d.name='Sales'
order by e.employee_id desc;

--------- 4 -------------  Employee Departments

select 
e.employee_id,
e.first_name ,
e.salary,
d.name as department_name
from employees as e
right join departments as d on e.department_id=d.department_id
where e.salary>15000
order by e.department_id desc
limit 5;





select employee_id,first_name,salary,dep.name as department_name 
from employees as e right join
departments as dep
using(`department_id`)
where salary>15000
order by dep.department_id desc
limit 5;

--------- 5 -------------  Employees Without Project

select e.employee_id,e.first_name
from employees as e
left join employees_projects as ep
on ep.employee_id=e.employee_id
where  ep.employee_id is null
order by e.employee_id desc
limit 3;

--------- 6 -------------  Employees Hired After

select e.first_name,e.last_name,e.hire_date,d.name from employees as e
join departments as d
on d.department_id=e.department_id
where date(e.hire_date)>'1999/1/1' and (d.name='Sales'or d.name='Finance')
order by e.hire_date asc

--------- 7 -------------  Employees with Project

select e.employee_id,e.first_name,p.name as project_name from employees as e
join employees_projects as ep
on e.employee_id=ep.employee_id
join projects as p
on ep.project_id=p.project_id
where date(p.start_date)>'2002/08/13' and p.end_date is null
order by e.first_name asc,p.name asc
limit 5;

--------- 8 -------------  Employee 24

update projects as p
set p.name = ''
where year(p.start_date)>=2005;

select e.employee_id,e.first_name,p.name as project_name from employees as e
join employees_projects as ep
on e.employee_id=ep.employee_id
join projects as p
on ep.project_id=p.project_id
where e.employee_id=24
order by p.name asc;





SELECT emp.employee_id, emp.first_name,
 CASE
      WHEN YEAR (pro.start_date) > 2004 
	  THEN pro.name = NULL
      ELSE pro.name
      END
AS project_name
FROM employees as emp
Left join employees_projects as map on emp.employee_id = map.employee_id
Left JOIN projects as pro on map.project_id = pro.project_id
WHERE emp.employee_id = 24
ORDER BY project_name ASC;

--------- 9 -------------  Employee Manager

select e.employee_id,e.first_name,e2.employee_id,e2.first_name as manager_name
from employees as e
join employees as e2
on e.manager_id=e2.employee_id
where e.manager_id=3 or  e.manager_id=7
order by e.first_name asc;

--------- 10 ------------- Employee Summary

select e.employee_id,concat(e.first_name,' ',e.last_name)as employee_name,concat(e2.first_name,' ',e2.last_name) as manager_name
,d.name as department_name
from employees as e
join employees as e2
on e.manager_id=e2.employee_id
join departments as d
on d.department_id=e.department_id
order by e.employee_id asc
limit 5;

--------- 11 ------------- Min Average Salary

select avg(e.salary) as min_average_salary  from employees as e
group by e.department_id
order by min_average_salary
limit 1;

--------- 12 ------------- Highest Peaks in Bulgaria



--------- 13 ------------- Count Mountain Ranges



--------- 14 ------------- Countries with Rivers



--------- 15 ------------- Continents and Currencies



--------- 16 ------------- Countries without any Mountains



--------- 17 ------------- Highest Peak and Longest River by Country

SELECT c.country_name,
       max(p.elevation)as highest_peak_elevation,
       max(r.length)as longest_river_length
from countries as c
left join mountains_countries as mcon mc.country_code=c.country_code
left join peaks as pon mc.mountain_id=p.mountain_id
left join countries_rivers as cron c.country_code=cr.country_code
left join rivers as ron cr.river_id=r.id
group by c.country_name
order by highest_peak_elevation desc,
longest_river_length desc, c.country_name asc
limit 5


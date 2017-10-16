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

select peak_name,river_name,
lower(concat(peak_name,lower(substring(river_name,2)))) as mix from peaks as p,rivers as r
where right(p.peak_name,1)=left(r.river_name,1);

-------12-----------

select g.name,DATE_FORMAT(start, '%Y-%m-%d') as start  from games as g
where year(g.`start`)>=2011 and year(g.`start`)<=2012
order by g.`start`
limit 50;

-------13----------

select user_name,
SUBSTRING_INDEX(email,'@',-1) as `Email Provider`
from users
order by `Email Provider`,user_name

-------14-----------

select u.user_name,u.ip_address from users as u
where u.ip_address like '___.1%.%.___'
 order by u.user_name asc;

------15----------

select name as Game,
case when hour(start) between 0 and 11 then 'Morning'
     when hour(start) between 12 and 17 then 'Afternoon'
     when hour(start) between 18 and 23 then 'Evening'
end as 'Part of the day',
case when duration <=3 then 'Extra Short'
      when duration between 4 and 6 then 'Short'
      when duration between 7 and 10 then 'Long'
      else 'Extra Long' end as 'Duration'
from games;

------16----------

select product_name,
order_date,
DATE_ADD(order_date, INTERVAL 3 DAY)   as pay_due,
DATE_ADD( order_date, INTERVAL 1 month )  as deliver_due
from orders;

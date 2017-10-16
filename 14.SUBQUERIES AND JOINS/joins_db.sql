----- 1 ----  Managers

select e.employee_id, concat(first_name, " ", last_name) as `full_name`, d.department_id, d.name
from employees as e
right join departments as d on d.manager_id = employee_id order by e.employee_id limit 5;

----- 2 ----  Towns and Addresses

select t.town_id, t.name, a.address_text
from towns as t
left join addresses as a
on t.town_id = a.town_id
where t.name = "San Francisco" or t.name = "Sofia" or t.name = "Carnation"
order by town_id, address_id;

----- 3 -----  Employees Without Managers

select e.employee_id,e.first_name,e.last_name,e.department_id,e.salary from employees as e
where e.manager_id is null;

----- 4 -------- High Salary

select count(e.employee_id) as `count` from employees as e
where e.salary >
(select AVG(salary) as 'average_salary' from employees);
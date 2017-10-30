--------- 1 -------------
delimiter $$
drop procedure if exists usp_get_employees_salary_above_35000;

create procedure usp_get_employees_salary_above_35000()
begin
  select e.first_name,e.last_name from employees as e
  where e.salary>35000
group by e.first_name asc,e.last_name,e.employee_id;
end $$

call usp_get_employees_salary_above_35000();

----------- 2 ---------------------  02. Employees with Salary Above Number

delimiter $$
drop procedure if exists usp_get_employees_salary_above;

create procedure usp_get_employees_salary_above(salary_llimit decimal(19,4))
begin
  select e.first_name,e.last_name from employees as e
  where e.salary>=salary_llimit
  group by e.first_name asc,e.last_name,e.employee_id;
end $$

call usp_get_employees_salary_above(13500.0001);

------ 3 ------------- 3.	Town Names Starting With





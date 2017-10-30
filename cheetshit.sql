delimiter $$
drop procedure if exists usp_get_employees_salary_above_35000;

create procedure usp_get_employees_salary_above_35000()
begin
  select e.first_name,e.last_name from employees as e
  where e.salary>35000
group by e.first_name asc,e.last_name,e.employee_id;
end $$

call usp_get_employees_salary_above_35000();



delimiter $$
drop procedure if exists ;

create procedure usp_get_employees_salary_above_35000()
begin
  
end $$

call usp_get_employees_salary_above_35000();

---------------------------
---------------------------

create procedure usp_get_employees_salary_above_35000()
begin
  select e.first_name,e.last_name from employees as e
  where e.salary>35000
group by e.first_name asc,e.last_name,e.employee_id;
end

---------1--------------



---------2--------------  2. Employees Promotion

/* DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name varchar(20))
BEGIN
  update employees set salary = salary*1.05
  where department_id=(select department_id from departments where name=department_name);
END $$ */



/* DELIMITER $$
create procedure usp_raise_salaries(department_name varchar(50))
begin
	update employees e inner join departments as d on e.department_id = d.department_id 
	set salary = salary + salary * 0.05
	where d.name = department_name;
end 
END $$ */


call  usp_raise_salaries ('Tool design')


select e.first_name,e.salary 
from employees as e
where department_id=2;

---------3--------------

---------4--------------


---------5--------------


---------6--------------



---------7--------------
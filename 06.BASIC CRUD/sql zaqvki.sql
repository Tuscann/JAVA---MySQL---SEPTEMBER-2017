--1---

-- use hospital;
select e.id,e.first_name,e.last_name,e.job_title from employees as e 
order by e.id asc 

--2-------

-- use hospital;
select e.id,concat(e.first_name,' ',e.last_name)as full_name ,e.job_title,e.salary from employees as e 
where e.salary>1000
 order by e.id asc 
 
--- 3 ---

-- use hospital;
 update employees as e
 set e.salary=e.salary*1.1
 where e.job_title="Therapist";

  select e.salary from employees as e
  order by e.salary asc
  
-- 4 -------

select*from employees
where salary=(select max(salary)from employees)

--- 5 ---

-- use hospital;
select*from employees as e
where e.salary>=1600 and e.department_id=4
order by e.id asc 

--- 6 ---

-- use hospital;
delete from employees 
where department_id=1 or department_id=2;
select*from employees

  
  
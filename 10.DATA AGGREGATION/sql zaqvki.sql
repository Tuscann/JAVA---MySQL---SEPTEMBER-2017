--- 1 -------

select e.department_id,count(e.department_id)
from employees as e
group by e.department_id
order by e.department_id;

---- 2 ----------

select e.department_id,ROUND(avg(e.salary) ,2)as AverageSalary   
from employees as e
group by e.department_id
order by e.department_id;

-----3-----------

select e.department_id,min(e.salary)as MinSalary   
from employees as e
group by e.department_id
having min(e.salary)>800
order by e.department_id;

------4--------------

select count(p.id)+1 as count from products  as p
where p.id=2 and p.price>8
group by p.id

------5-------------

select p.category_id,ROUND(avg(p.price),2)as averagePrice,ROUND(min(p.price),2)as CheapestProduct,ROUND(max(p.price),2)as MostExpensiveProduct  from products as p
group by p.category_id
order by p.category_id

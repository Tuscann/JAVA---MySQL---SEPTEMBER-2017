--- 1 ---

SELECT title FROM books WHERE SUBSTRING(title, 1, 3) = "The"

--- 2 ---

select replace (b.title ,'The','***') as title from books as b
where Substring(b.title,1,3)='The' order by b.id


--- 3 ---

select round(sum(b.cost),2)as sum
from books as b


--- 4 ---

select concat(a.first_name," ", a.last_name )as FullName 
,DATEDIFF(a.died,a.born)as DaysLived 
from authors as a


--- 5 ---

select b.title from books as b
where b.title like concat('Harry Potter','%')

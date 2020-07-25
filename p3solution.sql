-- first solution keeps the nulls i.e. users that never became power users 
/*
select id.user_id, row.dates, row.row_number

from (select distinct user_id from chris1.problem3) id 

left outer join (select user_id, problem3.date as dates, ROW_NUMBER() over (PARTITION BY user_id order by problem3.date) 
from chris1.problem3 ) row 

on row.row_number = 10 and id.user_id = row.user_id

order by user_id
; 
*/

 


-- why did i have to swap from and join sub queries ? ? ? 
--2nd solution just shows power uses but doesn't need a join 
/*
select table2.user_id, table2.dates, table2.pos 

from ( 
select user_id, problem3.date as dates, ROW_NUMBER() over (PARTITION BY user_id order by problem3.date) as pos 
from chris1.problem3  
) table2

where table2.pos = 10 
 */
;

 

select user_id, date 

from ( select user_id, date, ROW_NUMBER() over ( PARTITION BY user_id order by date) as row from chris1.problem3)a  

where a.row = 10 
order by user_id; 


























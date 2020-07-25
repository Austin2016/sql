/*

select user_id, sum(transaction_amount) as sum from ( 

select * 

from chris1.problem4a

union 


select * 

from chris1.problem4b 
)  stacked 

group by user_id 
order by user_id
limit 1000
; 
*/
 --this above solution shows the total spent by each user in 2 months (march , april)
   --march transactions coming from table a and april from b ...the union combines both. 
/*
select 
	stack.user_id, 
	stack.dates, 
	sum(stack.transaction_amount ) 
	over (PARTITION BY  stack.user_id ORDER BY stack.user_id asc rows between unbounded preceding and current row)  
	as total_on_day 
from 
	(select * 

	from chris1.problem4a

	union 

	select * 

	from chris1.problem4b ) stack 
limit 100
;

 
*/

--this above solution is kind of a hack ... got the weird window function from a webstie 
select stack1.user_id, stack1.dates, sum(stack2.transaction_amount) as running 

from ( 
	select * 

	from chris1.problem4a

	union 

	select * 

	from chris1.problem4b ) stack1

left outer join  (
	select * 

	from chris1.problem4a

	union 

	select * 

	from chris1.problem4b ) stack2

on stack1.user_id=stack2.user_id and stack1.dates>= stack2.dates
group by stack1.user_id,stack1.dates
order by stack1.user_id, stack1.dates
; 

--p2solution.sql 

--% of uses only on mobile , % of users only on web , % of uses in both 

/* bunch of random expiriments before the actual code 
select leftmobile.mobile_count, rightweb.web_count 

from (

	select count(*) as mobile_count 

		from ( select user_id from chris1.problem1a  group by user_id ) mobile 

) leftmobile 


inner join (

	select count(*) as web_count 

		from ( select user_id from chris1.problem1b  group by user_id ) web 

) rightweb

on true ;

*/
 --problem1a is the table for mobile 
 --problem 1b is the table for web 
	
-- first solution  



select 
 100 * ( count(*) - count(first.web) )::decimal / count(*)  as m_only_percent, 
 100 * ( count(*) - count(first.mobile) )::decimal / count(*)  as w_only_percent,
 100 * ( count(first.web) + count(first.mobile) - count(*) )::decimal / count(*)  as both_percent 



from ( select problem1a.user_id as mobile, problem1b.user_id as web 
	from chris1.problem1a  
	full outer join chris1.problem1b 
	on problem1a.user_id = problem1b.user_id 
	group by problem1a.user_id, problem1b.user_id ) first 
    
; 



--------------2nd solution  , seems easier to understand as a reader 

select 
 100 *  sum(mobonly)::decimal / count(*)  as m_only_percent, 
 100 *  sum(webonly)::decimal / count(*)  as w_only_percent,
 100 *  sum(bothh)::decimal   / count(*)  as both_percent 



from ( select m.user_id as mobile, w.user_id as web, 
		
	    case when m.user_id is null then 1 else 0 end as webonly,
	    case when w.user_id is null then 1 else 0 end as mobonly,
	    case when m.user_id is not null and w.user_id is not null then 1 else 0 
	    end as bothh



	    from (select distinct user_id from chris1.problem1a) m   
      	full outer join (select distinct user_id from chris1.problem1b) w 
	    on m.user_id = w.user_id 

	  ) first 
    
; 

--both is a key word i guess, causes syntax error when used as column name 


select big_table.m::decimal / (big_table.m_w + big_table.m + big_table.w) as mobile,
       big_table.w::decimal / (big_table.m_w + big_table.m + big_table.w) as web,
       big_table.m_w::decimal / (big_table.m_w + big_table.m + big_table.w) as bothh

from (
select  

(select count(*) 
from (
select user_id 
from chris1.problem1a
INTERSECT
select user_id 
from chris1.problem1b
) table_i ) as m_w , 

(select (select count(*) from ( select distinct user_id from chris1.problem1a)f) 
 - (select count(*) 
from (
select user_id 
from chris1.problem1a
INTERSECT
select user_id 
from chris1.problem1b
)table_i)) as m, 

(select (select count(*) from( select distinct user_id from chris1.problem1b)l)
- (select count(*) 
from (
select user_id 
from chris1.problem1a
INTERSECT
select user_id 
from chris1.problem1b
)table_i)) as w
) big_table
;






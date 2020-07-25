--a.user_id, a.sign_up_date, b.user_id, b.transaction_date, b.transaction_amount
/*
select avg(b.transaction_amount) 

from chris1.problem5a a 

 inner join  (

	select user_id, date(transaction_date) as transaction_date, transaction_amount from chris1.problem5b  
	order by transaction_amount
) b 

on a.user_id = b.user_id and a.sign_up_date = b.transaction_date

  
;  */
 ------

 /*
select 

from (select * 

	  from chris1.problem5a a 

      inner join  (

		select user_id, date(transaction_date) as transaction_date, transaction_amount from chris1.problem5b  
		order by transaction_amount
	   ) b 			
 

	  on a.user_id = b.user_id and a.sign_up_date = b.transaction_date
) initial --key :user_id , gives you transaction  amount on sign up date 

inner join ( select count(*)/2 as location, ( count(*)/2 ) - 1 ) as other_location
  			  
  			 from chris1.problem5a a

 			 inner join  (

				select user_id, date(transaction_date) as transaction_date, transaction_amount from chris1.problem5b  
	
			) b

			on a.user_id = b.user_id and a.sign_up_date = b.transaction_date
) count 
on   

;
*/

/*
select count(*)/2 as location, ( ( count(*)/2 ) + 1 ) as other_location, count(*)%2
  			  
from chris1.problem5a a

inner join  ( select user_id, date(transaction_date) as transaction_date, transaction_amount 

			  from chris1.problem5b  
	
) b

on a.user_id = b.user_id and a.sign_up_date = b.transaction_date

;
*/
 
/*
select transaction_amount, ROW_NUMBER() over(order by transaction_amount) as row 

from chris1.problem5a a

inner join ( select user_id, date(transaction_date) as transaction_date, transaction_amount 

			  from chris1.problem5b  
	
) b

on a.user_id = b.user_id and a.sign_up_date = b.transaction_date
; 
*/

/* first version 
select location_table.avg,
	   case when min(location_table.type) = 0 then avg (row_table.transaction_amount)  
	   else min( row_table.transaction_amount) 
	   end as median




from (
			select transaction_amount, ROW_NUMBER() over(order by transaction_amount) as row 

			from chris1.problem5a a

			inner join ( select user_id, date(transaction_date) as transaction_date, transaction_amount 

						from chris1.problem5b  
	
			) b

			on a.user_id = b.user_id and a.sign_up_date = b.transaction_date


) row_table 

inner join (select count(*)/2 as location, ( ( count(*)/2 ) + 1 ) as other_location, 
			count(*)%2 as type, avg(b.transaction_amount)
  			  
			from chris1.problem5a a

			inner join  ( select user_id, date(transaction_date) as transaction_date, transaction_amount 

						  from chris1.problem5b  
	
			) b

			on a.user_id = b.user_id and a.sign_up_date = b.transaction_date


) location_table 

on  location = row or other_location = row
group by avg --why do i need this  ? 
;
*/ 

--2nd version 

select location_table.avg, avg(row_table.transaction_amount) as median 




from (
			select transaction_amount, ROW_NUMBER() over(order by transaction_amount) as row 

			from chris1.problem5a a

			inner join chris1.problem5b b 

			on a.user_id = b.user_id and a.sign_up_date = date(b.transaction_date)


) row_table 

inner join (

			select (count(*) + 1) / 2  as location,  (count(*) + 2) / 2 as other_location, 
			avg(b.transaction_amount)
  			  
			from chris1.problem5a a

			inner join chris1.problem5b b 

			on a.user_id = b.user_id and a.sign_up_date = date(b.transaction_date)


) location_table 

on  location = row or other_location = row
group by avg --why do i need this  ? 
;




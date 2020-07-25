
--Query 1 

/*
select table1.country, table1.country_count

from(
	select max(country_count), min(country_count)

		from(	
			select country ,count(country) as country_count  


			from chris1.problem6


			group by country
			order by country_count desc  
	
		) table1 
) table2 
inner join( 
           select country ,count(country) as country_count  


			from chris1.problem6


			group by country
			order by country_count desc
	

)table1 

on table2.max = table1.country_count or table2.min = table1.country_count 
;
*/

--Query 2 


/*
A query that returns for each country the first and the last user who signed up (if that
country has just one user, it should just return that single user)
*/

select final1.country as country, final2.last_user, final1.first_user

from(	
	select a.country, a.user_id as first_user

	from chris1.problem6 a

	inner join( 
				select country, min(created_at)
				from chris1.problem6 
				group by  country 
	) times1  


	on a.created_at = times1.min and a.country = times1.country  

) final1 

left outer join( 
	            select a.country, a.user_id as last_user


	            from chris1.problem6 a

	            inner join( 
				          select country, max(created_at)
				          from chris1.problem6 
				          group by  country
				          ) times2 
	            on a.created_at = times2.max and a.country = times2.country 
	            


)final2 

on final1.country = final2.country
order by country 
;

-- \i /Users/Austin/p6solution.sql;
--query 3 ( same problem as 2 but different answer)


/*
select Table1.country, Table1.max as last_user, Table2.min as first_user

from(
	select country, user_id as max 
		from (
			  select user_id, created_at, country,   
		  	  RANK() over(partition by country order by created_at desc) as max
		      from chris1.problem6
        ) test 
	where  max<2 
)Table1 

inner join(
	      select country, user_id as min 
		  from (
			  select user_id, created_at, country,   
		  	  RANK() over(partition by country order by created_at) as min
		      from chris1.problem6
          ) test2 
	      where  min<2
)Table2 

on Table1.country = Table2.country 

*/



--select index, max(time) as time1 from chris1.problem1 group by index; 
-------this table has number of rows = number of unique index's from main table
-------key is index


--select a.index, max(a.time) as time 2 

--from chris1.problem1 a  

--inner join (select index, max(time) as time1 from chris1.problem1 group by index) latest
 
--on  a.index = latest.index and a.time < latest.time1 
--group by a.index 
--order by a.index
--limit 100 
--;                     

------this table has number of rows = number of unique rows from main table - 
------number of rows from main table with indexes that don't repeat 

select first.index, first.time1 - second.time2

from (select index, max(time) as time1 from chris1.problem1 group by index) first  

left outer join( select a.index, max(a.time) as time2 

                 from chris1.problem1 a  

                inner join(select index, max(time) as time1 from chris1.problem1 group by index
                 ) latest
                 on  a.index = latest.index and a.time < latest.time1 
                 group by a.index 
                 order by a.index
) second 

on second.index = first.index
order by first.index
limit 100;

/*
select distinct table1.index, max(table1.time1) - max(chris1.problem1.time) as dif 

from(    select index, max(time) as time1 from chris1.problem1 group by index 

)table1 

left outer join chris1.problem1  

on table1.index = chris1.problem1.index and  table1.time1 != chris1.problem1.time 
group by table1.index
limit 100
; 
*/ 



    
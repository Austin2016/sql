--psolution1_window

--select index, max(time) as time1 from chris1.problem1 group by index; 

--select 
 --index, 
 --time, 
 --RANK() over (PARTITION BY index order by time desc )

--from chris1.problem1 
--; 
------


select
max.index,
max.time1 - ranked.time as dif 

from (select index, max(time) as time1 from chris1.problem1 group by index) max 

left outer join (select 
  index, 
  time, 
  RANK() over (PARTITION BY index order by time desc )

  from chris1.problem1 ) ranked

on max.index = ranked.index and ranked.rank = 2 

order by max.index
; 

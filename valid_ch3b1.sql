-- c

-- First solution
-- select s.SID from supply s join product p on p.PID = s.PID where p.color = 'red'
-- intersect 
-- select s.SID from supply s join product p on p.PID = s.PID where p.color = 'blue';

-- Second solution
select sr.sid
from Supplier sr 
where exists (
  select 1
  from Supply sy join Product p on p.pid = sy.pid
  where sy.sid = sr.sid and p.color = 'red'
)
and exists (
  select 1
  from Supply sy join Product p on p.pid = sy.pid
  where sy.sid = sr.sid and p.color = 'blue'
);

-- d

-- select s.SID
-- from supply s join product p on s.PID = p.PID and p.color = 'red'
-- group by s.SID
-- having count(distinct s.PID) = (select count(*) from product where color = 'red');

-- select SID from supplier sp
-- where not exists (
--   select 1 from product p where p.color = 'red'
--     and not exists (select 1 from supply s where s.SID = sp.SID and s.PID = p.PID)
-- );


-- e

-- select s.SID 
-- from supply s  
-- join product p on s.PID = p.PID and p.color = 'red'
-- group by s.SID 
-- having count(distinct s.PID) = (select count(*) from product where color = 'red')
-- intersect 
-- select s.SID 
-- from supply s  
-- join product p on s.PID = p.PID and p.color = 'blue'
-- group by s.SID 
-- having count(distinct s.PID) = (select count(*) from product where color = 'blue');

-- f

-- select s.SID 
-- from supply s  
-- join product p on s.PID = p.PID and p.color = 'red'
-- group by s.SID 
-- having count(distinct s.PID) = (select count(*) from product where color = 'red')
-- union 
-- select s.SID 
-- from supply s  
-- join product p on s.PID = p.PID and p.color = 'blue'
-- group by s.SID 
-- having count(distinct s.PID) = (select count(*) from product where color = 'blue');

-- g

-- select sp1.sid, sp2.sid
-- from supplier sp1, supplier sp2
-- where sp1.sid <> sp2.sid
--   and exists (select 1 from supply s1, supply s2
--               where s1.sid = sp1.sid and s2.sid = sp2.sid
--                 and s1.pid = s2.pid
--                 and s1.price > s2.price);

-- h 

-- select p.pid
-- from supply s  
-- join product p on s.pid = p.pid 
-- group by p.pid
-- having count(distinct s.sid) >= 2;

-- i 

-- select s.pid
-- from supply s 
-- join supplier sp on sp.sid = s.sid and sp.name = 'Dustin'
-- where s.price = (select max(price) from supply where sid = sp.sid);

-- j 

-- select s.pid
-- from supply s
-- join supplier sp on sp.sid = s.sid
-- where s.price < 200
-- group by s.pid 
-- having count(distinct sp.sid) = (select count(distinct sid) from supplier);